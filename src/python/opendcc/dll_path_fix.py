# Copyright Contributors to the OpenDCC project
# SPDX-License-Identifier: Apache-2.0

# Explanation:
# Since Python 3.8 python deprecated dll resolution via PATH env variable.
# The new recommended way is using os.add_dll_directory()
# The code below is needed for correct Qt and PySide dll resolution in internal builds where
# environment is configured via .bat script or rez.
import sys

if sys.platform == "win32" and sys.version_info[0] >= 3 and sys.version_info[1] >= 8:
    import os

    # similar to https://github.com/PixarAnimationStudios/OpenUSD/blob/dev/pxr/base/tf/__init__.py#L40-L45
    import_paths = os.getenv("PATH", "")
    for path in reversed(import_paths.split(os.pathsep)):
        if os.path.exists(path) and path != ".":
            abs_path = os.path.abspath(path)
            os.add_dll_directory(abs_path)

    import ctypes.util as cu

    qt_path = cu.find_library("Qt5Core.dll")
    shiboken_path = cu.find_library(
        "shiboken2.cp{}{}-win_amd64.dll".format(sys.version_info[0], sys.version_info[1])
    )
    if qt_path:
        os.add_dll_directory(os.path.dirname(qt_path))
    if shiboken_path:
        os.add_dll_directory(os.path.dirname(shiboken_path))
