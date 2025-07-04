#!/bin/bash

# get the actual path
export START_SCRIPT_DIR="$(dirname "$(readlink -f "${BASH_SOURCE[0]}")")"

# START_SCRIPT_DIR will be inherited by filemanager.sh.
exec "${START_SCRIPT_DIR}/src/filemanager.sh" "$@"