//
// Copyright 2022 Pixar
//
// Licensed under the terms set forth in the LICENSE.txt file available at
// https://openusd.org/license.
//
// Modifications copyright Contributors to the OpenDCC project
// SPDX-License-Identifier: Apache-2.0

#include "hydra_op_scene_graph_tree_widget.h"

#include <QClipboard>
#include <QContextMenuEvent>
#include <QGuiApplication>
#include <QHeaderView>
#include <QMenu>
#include <QTimer>
#include <QTreeWidgetItem>

#include <unordered_set>

PXR_NAMESPACE_OPEN_SCOPE

//-----------------------------------------------------------------------------

class HydraOpTreeItem : public QTreeWidgetItem
{
public:
    HydraOpTreeItem(QTreeWidgetItem *parentItem, const SdfPath &primPath, bool queryOnExpansion = false)
        : QTreeWidgetItem(parentItem)
        , _primPath(primPath)
        , _queryOnExpansion(queryOnExpansion)
    {
        if (queryOnExpansion)
        {
            setChildIndicatorPolicy(QTreeWidgetItem::ShowIndicator);
        }

        if (primPath.IsPropertyPath())
        {
            std::string name = "." + primPath.GetName();
            setText(0, name.c_str());
        }
        else
        {
            setText(0, primPath.GetNameToken().data());
        }

        if (_IsInExpandedSet())
        {
            // NOTE: defer expansion because pulling immediately triggers yet
            //       ununderstood crashes with
            //       PhdRequest::ExtractOptionalValue as called from
            //       HdDataSourceLegacyPrim
            QTimer::singleShot(0, [this]() { this->setExpanded(true); });
        }
    }

    const SdfPath &GetPrimPath() { return _primPath; }

    void WasExpanded(HydraOpTree *treeWidget)
    {
        _SetIsInExpandedSet(true);

        if (!_queryOnExpansion)
        {
            return;
        }

        _queryOnExpansion = false;

        int count = childCount();
        if (count)
        {
            for (int i = 0; i < count; ++i)
            {
                if (HydraOpTreeItem *childItem = dynamic_cast<HydraOpTreeItem *>(child(0)))
                {
                    treeWidget->_RemoveSubtree(childItem->_primPath);
                }
            }
        }

        if (!treeWidget->_inputSceneIndex)
        {
            return;
        }

        for (const SdfPath &childPath : treeWidget->_inputSceneIndex->GetChildPrimPaths(_primPath))
        {

            HdSceneIndexPrim prim = treeWidget->_inputSceneIndex->GetPrim(childPath);

            HydraOpTreeItem *childItem = new HydraOpTreeItem(this, childPath, true);

            treeWidget->_AddPrimItem(childPath, childItem);
            childItem->setText(1, prim.primType.data());
        }

        if (!childCount())
        {
            setChildIndicatorPolicy(QTreeWidgetItem::DontShowIndicator);
        }
    }

    void WasCollapsed() { _SetIsInExpandedSet(false); }

private:
    SdfPath _primPath;
    bool _queryOnExpansion;

    using _PathSet = std::unordered_set<SdfPath, SdfPath::Hash>;
    static _PathSet &_GetExpandedSet()
    {
        static _PathSet expandedSet;
        return expandedSet;
    }

    bool _IsInExpandedSet()
    {
        _PathSet &ps = _GetExpandedSet();
        return ps.find(_primPath) != ps.end();
    }

    void _SetIsInExpandedSet(bool state)
    {
        _PathSet &ps = _GetExpandedSet();
        if (state)
        {
            ps.insert(_primPath);
        }
        else
        {
            ps.erase(_primPath);
        }
    }
};

//-----------------------------------------------------------------------------

HydraOpTree::HydraOpTree(QWidget *parent)
    : QTreeWidget(parent)
{
    setHeaderLabels({ "Name", "Type" });
    setAllColumnsShowFocus(true);

    header()->setSectionResizeMode(0, QHeaderView::Stretch);
    header()->setSectionResizeMode(1, QHeaderView::Fixed);
    header()->resizeSection(1, fontMetrics().averageCharWidth() * 10);
    header()->setStretchLastSection(false);

    connect(this, &QTreeWidget::itemSelectionChanged, [this]() {
        if (!this->_inputSceneIndex)
        {
            return;
        }

        QList<QTreeWidgetItem *> items = this->selectedItems();
        if (items.empty())
        {
            Q_EMIT PrimSelected(SdfPath(), nullptr);
            return;
        }

        if (HydraOpTreeItem *primItem = dynamic_cast<HydraOpTreeItem *>(items[0]))
        {

            Q_EMIT PrimSelected(primItem->GetPrimPath(), this->_inputSceneIndex->GetPrim(primItem->GetPrimPath()).dataSource);
        }
    });

    connect(this, &QTreeWidget::itemExpanded, [this](QTreeWidgetItem *item) {
        if (HydraOpTreeItem *siItem = dynamic_cast<HydraOpTreeItem *>(item))
        {
            siItem->WasExpanded(this);
        }
    });

    connect(this, &QTreeWidget::itemCollapsed, [](QTreeWidgetItem *item) {
        if (HydraOpTreeItem *siItem = dynamic_cast<HydraOpTreeItem *>(item))
        {
            siItem->WasCollapsed();
        }
    });
}

void HydraOpTree::PrimsAdded(const HdSceneIndexBase &sender, const AddedPrimEntries &entries)
{
    for (const AddedPrimEntry &entry : entries)
    {
        if (HydraOpTreeItem *item = _GetPrimItem(entry.primPath))
        {
            item->setText(1, entry.primType.data());

            if (item->isSelected())
            {
                Q_EMIT itemSelectionChanged();
            }
        }
    }
}

void HydraOpTree::PrimsRemoved(const HdSceneIndexBase &sender, const RemovedPrimEntries &entries)
{
    bool sortState = isSortingEnabled();
    setSortingEnabled(false);

    for (const RemovedPrimEntry &entry : entries)
    {
        if (HydraOpTreeItem *item = _GetPrimItem(entry.primPath, false))
        {

            if (item->parent())
            {
                item->parent()->takeChild(item->parent()->indexOfChild(item));
            }

            _ItemMap::iterator it = _primItems.begin();

            // XXX items are currently stored flat so this loop will not scale
            //     if run repeatedly
            while (it != _primItems.end())
            {
                if ((*it).first.HasPrefix(entry.primPath))
                {
                    _ItemMap::iterator nextIt = it;
                    ++nextIt;
                    _primItems.erase(it);
                    it = nextIt;
                }
                else
                {
                    ++it;
                }
            }

            // TODO selection change, etc
        }
    }

    setSortingEnabled(sortState);
}

void HydraOpTree::PrimsDirtied(const HdSceneIndexBase &sender, const DirtiedPrimEntries &entries)
{

    QList<QTreeWidgetItem *> items = selectedItems();
    if (items.empty())
    {
        return;
    }

    if (HydraOpTreeItem *item = dynamic_cast<HydraOpTreeItem *>(items[0]))
    {
        SdfPath selectedPath = item->GetPrimPath();

        // collapse all locators for the selected prim within the
        // batch to minimize repeated rebuild
        HdDataSourceLocatorSet selectedItemLocators;

        for (const DirtiedPrimEntry &entry : entries)
        {
            if (entry.primPath == selectedPath)
            {

                selectedItemLocators.insert(entry.dirtyLocators);
            }
        }

        if (!selectedItemLocators.IsEmpty())
        {
            QTimer::singleShot(0, [this, selectedPath, selectedItemLocators]() { Q_EMIT PrimDirtied(selectedPath, selectedItemLocators); });
        }
    }
}
#if PXR_VERSION >= 2408

void HydraOpTree::PrimsRenamed(const HdSceneIndexBase &sender, const RenamedPrimEntries &entries)
{
    ConvertPrimsRenamedToRemovedAndAdded(sender, entries, this);
}

#endif
void HydraOpTree::SetSceneIndex(HdSceneIndexBaseRefPtr inputSceneIndex)
{
    if (_inputSceneIndex)
    {
        _inputSceneIndex->RemoveObserver(HdSceneIndexObserverPtr(this));
    }

    _primItems.clear();
    clear();

    _inputSceneIndex = inputSceneIndex;
    _inputSceneIndex->AddObserver(HdSceneIndexObserverPtr(this));
}

void HydraOpTree::Requery(bool lazy)
{
    //_primItems.clear();
    // clear();

    _primItems[SdfPath::AbsoluteRootPath()] = new HydraOpTreeItem(invisibleRootItem(), SdfPath::AbsoluteRootPath(), true);
}

HydraOpTreeItem *HydraOpTree::_GetPrimItem(const SdfPath &primPath, bool createIfNecessary)
{
    auto it = _primItems.find(primPath);
    if (it != _primItems.end())
    {
        return it->second;
    }

    if (!createIfNecessary)
    {
        return nullptr;
    }

    QTreeWidgetItem *parentItem = nullptr;

    if (primPath == SdfPath::AbsoluteRootPath())
    {
        parentItem = invisibleRootItem();
    }
    else
    {
        parentItem = _GetPrimItem(primPath.GetParentPath(), true);
    }

    if (!parentItem)
    {
        return nullptr;
    }

    HydraOpTreeItem *item = new HydraOpTreeItem(parentItem, primPath);
    _primItems[primPath] = item;

    return item;
}

void HydraOpTree::_RemoveSubtree(const SdfPath &primPath)
{
    HydraOpTreeItem *item = _GetPrimItem(primPath, false);
    if (!item)
    {
        return;
    }

    if (item->parent())
    {
        item->parent()->takeChild(item->parent()->indexOfChild(item));
    }

    _ItemMap::const_iterator it = _primItems.begin();
    while (it != _primItems.end())
    {
        if ((*it).first.HasPrefix(primPath))
        {
            _ItemMap::const_iterator it2 = it;
            ++it;
            _primItems.erase(it2);
        }
        else
        {
            ++it;
        }
    }
}

void HydraOpTree::_AddPrimItem(const SdfPath &primPath, HydraOpTreeItem *item)
{
    _primItems[primPath] = item;
}

void HydraOpTree::contextMenuEvent(QContextMenuEvent *event)
{
    QTreeWidgetItem *item = itemAt(event->pos());

    if (item)
    {
        QPoint globalPos(event->pos().x(), visualItemRect(item).bottom());

        if (header()->isVisible())
        {
            globalPos = QPoint(globalPos.x(), globalPos.y() + header()->height());
        }

        if (HydraOpTreeItem *typedItem = dynamic_cast<HydraOpTreeItem *>(item))
        {
            QMenu menu;

            menu.addAction("type: " + typedItem->text(1))->setEnabled(false);
            menu.addSeparator();

            menu.addAction("Copy Prim Path", [typedItem]() {
                QClipboard *clipboard = QGuiApplication::clipboard();
                QString pathStr(typedItem->GetPrimPath().GetAsString().c_str());
                clipboard->setText(pathStr, QClipboard::Clipboard);
                clipboard->setText(pathStr, QClipboard::Selection);
            });

            // TODO, emit a signal so external clients can extend this menu
            menu.exec(mapToGlobal(globalPos));
        }
    }
}

PXR_NAMESPACE_CLOSE_SCOPE
