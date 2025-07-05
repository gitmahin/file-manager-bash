#!/usr/bin/env bats

export BATS_TMPDIR=""


setup(){

  # get the containing directory of this file
  # use $BATS_TEST_FILENAME instead of ${BASH_SOURCE[0]} or $0,
  # as those will point to the bats executable's location or the preprocessed file respectively
  DIR="$(cd "$( dirname "$BATS_TEST_FILENAME" )" >/dev/null 2>&1 && pwd)"
  # make executables in src/ visible to PATH
  PATH="$DIR/../src:$PATH" # Now we can directly access the file in @test. (e.g. run lib.sh)

  load_lib() {
    local name="$1"
    bats_load_safe "test_helper/${name}/load"
  }
  
  # loading bats assertions
  load_lib 'bats-support' || bats_load_safe "${DIR}/../../node_modules/bats-support/load" # this is for npm
  load_lib 'bats-assert' ||  bats_load_safe "${DIR}/../../node_modules/bats-assert/load" # this is for npm
  load_lib 'bats-file' ||  bats_load_safe "${DIR}/../../node_modules/bats-file/load" # this is for npm

  # Setting temporary directory to test file and folder creation
  BATS_TMPDIR=$(mktemp -d -t bats-test-XXXXXX)
  # exporting for available in whole tests
  export TEMP_LIBSH_PATH="${BATS_TEST_DIRNAME}/../lib.sh"
}

# this hook will run after all tests have finished 
# teardown() {
  
# }

# bats test_tags=copy-files-default
@test "Should copy files 2 to 4 without custom output file-name and with default settings" {
  # exporting for avaiable in newly created subshells via -> bash -c
  export file_name="test.txt"
  export number_of_command=3

  # Entering the temporary bats folder
  cd "$BATS_TMPDIR" || exit 1

  # creating a file in temp bats folder
  run touch "$file_name"

  # bash -c command creates a new subshell to execute the string command.
  # Using single quotes around the command string to prevent the outer shell
  # from expanding variables or interpreting special characters prematurely.
  # This ensures the entire string is passed literally to the 'bash -c' subshell,
  # where variables like $TEMP_LIBSH_PATH, $file_name, and $number_of_command
  # (which are exported) are then correctly expanded by the inner subshell.
  run bash -c 'source $TEMP_LIBSH_PATH; copyNCreateFiles "$file_name" "$number_of_command" "" "" ""'

  # output of bats testing
  echo "ERROR DETAILS: <$output>"

  # status of bats testing. 
  # To make this status work properly we have to always return 0 or 1 in functions. 
  # Dont exit 1 or 0 in function cause it will exit the bats testing
  [ "$status" -eq 0 ]
  
  # available by assertions load in setup
  # as files are creating in a loop and always printing after each file creation
  # we can use assert_line instead of assert_output to validate the correct output of file-naming
  assert_file_exists "test-2.txt"
  assert_file_exists "test-3.txt"
  assert_file_exists "test-4.txt"
}

# bats test_tags=copy-files-modified
@test "Should copy files 5 to 9 with custom output file-name and modified settings" {
  export file_name="test.txt"
  export number_of_command=5
  export output_file_name="my-file.txt"
  export numbering_position="l"
  export start_numbering_from="5"

  cd "$BATS_TMPDIR" || exit 1
  run touch "$file_name"

  run bash -c 'source $TEMP_LIBSH_PATH; copyNCreateFiles "$file_name" "$number_of_command" "$numbering_position" "$start_numbering_from" "$output_file_name"'
  echo "ERROR DETAILS: <$output>"
  [ "$status" -eq 0 ]

  assert_file_exists "5-my-file.txt"
  assert_file_exists "6-my-file.txt"
  assert_file_exists "7-my-file.txt"
  assert_file_exists "8-my-file.txt"
  assert_file_exists "9-my-file.txt"
}


# bats test_tags=create-files-default
@test "Should create files 1 to 5 with default settings" {
  export file_name="my-file.txt"
  export number_of_command=5
  
  cd "$BATS_TMPDIR" || exit 1

  run bash -c 'source $TEMP_LIBSH_PATH; createFiles "$file_name" "$number_of_command"'
  echo "ERROR DETAILS: <$output>"
  [ "$status" -eq 0 ]

  assert_file_exists "my-file-1.txt"
  assert_file_exists "my-file-2.txt"
  assert_file_exists "my-file-3.txt"
  assert_file_exists "my-file-4.txt"
  assert_file_exists "my-file-5.txt"
}



# bats test_tags=create-folders-leftn
@test "Should create folders 1 to 3 with left numbering position" {
  export folder_name="myfolder"
  export number_of_command=3
  export numbering_position="l"

  cd "$BATS_TMPDIR" || exit 1

  run bash -c 'source $TEMP_LIBSH_PATH; createFolders "$folder_name" "$number_of_command" "$numbering_position"'
  [ "$status" -eq 0 ]

  assert_dir_exists "1-myfolder"
  assert_dir_exists "2-myfolder"
  assert_dir_exists "3-myfolder"
}

# bats test_tags=create-folders-rightn
@test "Should create folders 1 to 3 with right numbering position" {
  export folder_name="myfolder"
  export number_of_command=3
  export numbering_position="r"

  cd "$BATS_TMPDIR" || exit 1

  run bash -c 'source $TEMP_LIBSH_PATH; createFolders "$folder_name" "$number_of_command" "$numbering_position"'
  [ "$status" -eq 0 ]

  assert_dir_exists "myfolder-1"
  assert_dir_exists "myfolder-2"
  assert_dir_exists "myfolder-3"
}