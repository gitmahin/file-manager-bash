# !/bin/bash

load_lib() {
    local name="$1"
    bats_load_safe "test_helper/${name}/load"
}

setup_testing_ground() {
    export BATS_TMPDIR=""
    # get the containing directory of this file
    # use $BATS_TEST_FILENAME instead of ${BASH_SOURCE[0]} or $0,
    # as those will point to the bats executable's location or the preprocessed file respectively
    DIR="$(cd "$( dirname "$BATS_TEST_FILENAME" )" >/dev/null 2>&1 && pwd)"
    # make executables in src/ visible to PATH
    PATH="$DIR/../src:$PATH" # Now we can directly access the file in @test. (e.g. run lib.sh)

    # loading bats assertions
    load_lib 'bats-support' || bats_load_safe "${DIR}/../../node_modules/bats-support/load" # this is for npm
   
    # Setting temporary directory to test file and folder creation
    BATS_TMPDIR=$(mktemp -d -t bats-test-XXXXXX)
    # exporting for available in whole tests
    export TEMP_LIBSH_PATH="${BATS_TEST_DIRNAME}/../lib.sh"

    # Entering the temporary bats folder
    cd "$BATS_TMPDIR" || exit 1
}

setup_common_assertion(){
    load_lib 'bats-assert' ||  bats_load_safe "${DIR}/../../node_modules/bats-assert/load" # this is for npm
}

setup_file_assertion() {
    load_lib 'bats-file' ||  bats_load_safe "${DIR}/../../node_modules/bats-file/load" # this is for npm
}