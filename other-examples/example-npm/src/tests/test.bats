#!/usr/bin/env bats

export BATS_TMPDIR=""

setup(){
  # get the containing directory of this file
  # use $BATS_TEST_FILENAME instead of ${BASH_SOURCE[0]} or $0,
  # as those will point to the bats executable's location or the preprocessed file respectively
  DIR="$(cd "$( dirname "$BATS_TEST_FILENAME" )" >/dev/null 2>&1 && pwd)"
  # make executables in src/ visible to PATH
  PATH="$DIR/../src:$PATH" # Now we can directly access the file in @test. (e.g. run lib.sh)

  # loading bats assertions


  current_dir=$(pwd)

  # Setting temporary directory to test file and folder creation
  BATS_TMPDIR=$(mktemp -d -t bats-test-XXXXXX)
  # exporting for available in whole tests
  export TEMP_LIBSH_PATH="${BATS_TEST_DIRNAME}/../lib.sh"
}

# this hook will run after all tests have finished 
# teardown() {
  
# }

# bats test_tags=create-files-1
@test "Should copy and create files 2 to 4 without custom output file-name" {
  # exporting for avaiable in newly created subshells via -> bash -c
  export filename="test.txt"
  export number_of_command=3

  # Entering the temporary bats folder
  cd "$BATS_TMPDIR" || exit 1

  # creating a file in temp bats folder
  run touch "$filename"

  # bash -c command creates a new subshell to execute the string command.
  # Using single quotes around the command string to prevent the outer shell
  # from expanding variables or interpreting special characters prematurely.
  # This ensures the entire string is passed literally to the 'bash -c' subshell,
  # where variables like $TEMP_LIBSH_PATH, $filename, and $number_of_command
  # (which are exported) are then correctly expanded by the inner subshell.
  run bash -c 'source $TEMP_LIBSH_PATH; copyNCreateFiles "$filename" "" "$number_of_command"'

  # output of bats testing
  echo "ERROR DETAILS: <$output>"

  # status of bats testing. 
  # To make this status work properly we have to always return 0 or 1 in functions. 
  # Dont exit 1 or 0 in function cause it will exit the bats testing
  [ "$status" -eq 0 ]
  
  # available by assertions load in setup
  # as files are creating in a loop and always printing after each file creation
  # we can use assert_line instead of assert_output to validate the correct output of file-naming
  assert_line "Searching... [test.txt]"
  assert_line "Created: test-2.txt"
  assert_line "Created: test-3.txt"
  assert_line "Created: test-4.txt"
}

# bats test_tags=create-files-2
@test "Should copy and create files 2 to 6 with custom output file-name" {
  export file_name="test.txt"
  export number_of_command=5
  export output_file_name="my-file.txt"

  cd "$BATS_TMPDIR" || exit 1
  run touch "$file_name"

  run bash -c 'source $TEMP_LIBSH_PATH; copyNCreateFiles "$file_name" "$output_file_name" "$number_of_command"'
  echo "ERROR DETAILS: <$output>"
  [ "$status" -eq 0 ]

  assert_line "Searching... [test.txt]"
  assert_line "Created: my-file-2.txt"
  assert_line "Created: my-file-3.txt"
  assert_line "Created: my-file-4.txt"
  assert_line "Created: my-file-5.txt"
  assert_line "Created: my-file-6.txt"
}

# bats test_tags=create-folders-leftn
@test "Should create folders 1 to 3 with left numbering position" {
  export folder_name="myfolder"
  export number_of_command=3
  export numbering_position="l"

  cd "$BATS_TMPDIR" || exit 1

  run bash -c 'source $TEMP_LIBSH_PATH; createFolders "$folder_name" "$number_of_command" "$numbering_position"'
  [ "$status" -eq 0 ]
  assert_line "Created: 1-myfolder"
  assert_line "Created: 2-myfolder"
  assert_line "Created: 3-myfolder"
}

# bats test_tags=create-folders-rightn
@test "Should create folders 1 to 3 with right numbering position" {
  export folder_name="myfolder"
  export number_of_command=3
  export numbering_position="r"

  cd "$BATS_TMPDIR" || exit 1

  run bash -c 'source $TEMP_LIBSH_PATH; createFolders "$folder_name" "$number_of_command" "$numbering_position"'
  [ "$status" -eq 0 ]
  assert_line "Created: myfolder-1"
  assert_line "Created: myfolder-2"
  assert_line "Created: myfolder-3"
}