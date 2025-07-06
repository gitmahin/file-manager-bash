# !/bin/bash

load_lib() {
    local name="$1"
    bats_load_safe "test_helper/${name}/load"
}

setup_testing_ground() {
    # get the containing directory of this file
    # use $BATS_TEST_FILENAME instead of ${BASH_SOURCE[0]} or $0,
    # as those will point to the bats executable's location or the preprocessed file respectively
    DIR="$(cd "$( dirname "$BATS_TEST_FILENAME" )" >/dev/null 2>&1 && pwd)"
    # make executables in src/ visible to PATH
    PATH="$DIR/../src:$PATH" # Now we can directly access the file in @test. (e.g. run lib.sh)

    # loading bats assertions
    load_lib 'bats-support' || bats_load_safe "${DIR}/../../node_modules/bats-support/load" # this is for npm
    # exporting for available in whole tests
    export TEMP_LIBSH_PATH="${BATS_TEST_DIRNAME}/../lib.sh"
    
}

setup_common_assertion(){
    load_lib 'bats-assert' ||  bats_load_safe "${DIR}/../../node_modules/bats-assert/load" # this is for npm
}

setup_file_assertion() {
    load_lib 'bats-file' ||  bats_load_safe "${DIR}/../../node_modules/bats-file/load" # this is for npm
    
    # Setting temporary directory to test file and folder creation
    # the directory name is of the following form.
    # <prefix><test-filename>-<test-number>-<random-string>
    # You can see created temp directory on cd /tmp/ prefix -> filemanager. 
    TEST_TEMP_DIR="$(temp_make --prefix 'filemanager-')"
    # Entering the temporary bats folder
    cd "$TEST_TEMP_DIR" || exit 1
}

tear_down_file() {
    # remove temporary directory
    # If you dont delete temp directory for any specific test just initialize 
    # BATSLIB_TEMP_PRESERVE=1 in setup()
    temp_del "$TEST_TEMP_DIR"
}