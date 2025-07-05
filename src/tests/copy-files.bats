#!/usr/bin/env bats
# bats file_tags=copy-files

bats_load_safe "helper.bash"

setup() {
    setup_testing_ground
    setup_common_assertion
    setup_file_assertion
}

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
  echo "OUTPUT: <$output>"

  # status of bats testing. 
  # To make this status work properly we have to always return 0 or 1 in functions. 
  # Dont exit 1 or 0 in function cause it will exit the bats testing
  # [ "$status" -eq 0 ]

  # or use bats-assert
  assert_success
  
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
  echo "OUTPUT: <$output>"
  assert_success

  assert_file_exists "5-my-file.txt"
  assert_file_exists "6-my-file.txt"
  assert_file_exists "7-my-file.txt"
  assert_file_exists "8-my-file.txt"
  assert_file_exists "9-my-file.txt"

}