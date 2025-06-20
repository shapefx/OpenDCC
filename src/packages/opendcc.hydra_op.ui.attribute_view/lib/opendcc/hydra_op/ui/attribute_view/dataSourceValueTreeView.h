//
// Copyright 2022 Pixar
//
// Licensed under the terms set forth in the LICENSE.txt file available at
// https://openusd.org/license.
//
// Modifications copyright Contributors to the OpenDCC project
// SPDX-License-Identifier: Apache-2.0

#ifndef PXR_IMAGING_HDUI_DATA_SOURCE_VALUE_TREE_VIEW_H
#define PXR_IMAGING_HDUI_DATA_SOURCE_VALUE_TREE_VIEW_H

#include "pxr/pxr.h"

#include "pxr/imaging/hd/dataSource.h"

#include <QTreeView>

PXR_NAMESPACE_OPEN_SCOPE

class HduiDataSourceValueTreeView : public QTreeView
{
    Q_OBJECT;

public:
    HduiDataSourceValueTreeView(QWidget *parent = Q_NULLPTR);
    void SetDataSource(const HdSampledDataSourceHandle &dataSource);
    void Refresh();

private:
    HdSampledDataSourceHandle _dataSource;
};

PXR_NAMESPACE_CLOSE_SCOPE

#endif
