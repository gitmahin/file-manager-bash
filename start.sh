#!/bin/bash

# get the actual path
START_SCRIPT_DIR="$(dirname "$(readlink -f "${BASH_SOURCE[0]}")")"
exec "${START_SCRIPT_DIR}/src/filemanager.sh" "$@"