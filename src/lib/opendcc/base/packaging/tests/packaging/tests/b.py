# Copyright Contributors to the OpenDCC project
# SPDX-License-Identifier: Apache-2.0

from opendcc.packaging import PackageEntryPoint

entry_point_checker = 0


class FirstEntryPoint(PackageEntryPoint):
    def __init__(self):
        PackageEntryPoint.__init__(self)

    def initialize(self):
        global entry_point_checker
        entry_point_checker = 1

    def uninitialize(self):
        global entry_point_checker
        entry_point_checker = 2
