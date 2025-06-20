#!/bin/bash

# If $0 is a symlink, resolve it to a file
f="$0"
if [ -L "$f" ]; then
    f="$(readlink -f "$f" 2> /dev/null)"
    if [ "$?" != "0" ]; then
        f="$0"
    fi
fi

# Initialize application environment.
CUR_DIR="$(pwd)"
APP_DIR="`realpath "$(dirname "$f")"`"
cd "${APP_DIR}/../" && test -d "$APP_DIR"
source "opendcc_setup.sh"
cd "${CUR_DIR}"

# Now run the requested binary.
exec "$f.bin" "$@"
