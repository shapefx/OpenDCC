/*
 * Copyright Contributors to the OpenDCC project
 * SPDX-License-Identifier: Apache-2.0
 */

#pragma once

#include "opendcc/opendcc.h"
#include "opendcc/usd_editor/common_cmds/api.h"
#include "opendcc/base/commands_api/core/command.h"
#include "opendcc/base/commands_api/core/args.h"
#include "opendcc/app/core/undo/inverse.h"
#include "opendcc/app/core/api.h"

#include <pxr/usd/usd/stage.h>

OPENDCC_NAMESPACE_OPEN

namespace commands
{
    class OPENDCC_USD_EDITOR_COMMON_CMDS_API AECopyCommand : public UndoCommand
    {
    public:
        virtual CommandResult execute(const CommandArgs& args) override;
        virtual void undo() override;
        virtual void redo() override;

        static std::string cmd_name;
        static CommandSyntax cmd_syntax();
        static std::shared_ptr<Command> create_cmd();

    private:
        void do_cmd();

        std::unique_ptr<commands::UndoInverse> m_inverse;
    };
}

OPENDCC_NAMESPACE_CLOSE
