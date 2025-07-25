# Copyright Contributors to the OpenDCC project
# SPDX-License-Identifier: Apache-2.0

from opendcc.packaging import PackageEntryPoint
import opendcc.core as dcc_core
from pxr import Plug
import os


class ExpressionEntryPoint(PackageEntryPoint):
    def initialize(self, package):
        Plug.Registry().RegisterPlugins(os.path.join(package.get_root_dir(), "pxr_plugins"))
        app = dcc_core.Application.instance()
        app.register_event_callback(app.EventType.AFTER_UI_LOAD, lambda: self.init_ui())

    def init_ui(self):
        pass