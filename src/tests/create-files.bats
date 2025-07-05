#!/usr/bin/env bats
# bats file_tags=create-files

bats_load_safe "helper.bash"

setup(){
  setup_testing_ground
  setup_common_assertion
  setup_file_assertion
}

# bats test_tags=create-files-default
@test "Should create files 1 to 5 with default settings" {
  export file_name="my-file.txt"
  export number_of_command=5
  
  cd "$BATS_TMPDIR" || exit 1

  run bash -c 'source $TEMP_LIBSH_PATH; createFiles "$file_name" "$number_of_command"'
  echo "OUTPUT: <$output>"
  
  assert_success

  assert_file_exists "my-file-1.txt"
  assert_file_exists "my-file-2.txt"
  assert_file_exists "my-file-3.txt"
  assert_file_exists "my-file-4.txt"
  assert_file_exists "my-file-5.txt"
}

# bats test_tags=create-files-modified
@test "Should create files 5 to 9 with modified settings" {
  export file_name="my-file.txt"
  export number_of_command=5
  export numbering_position="l"
  export start_numbering_from="5"

  cd "$BATS_TMPDIR" || exit 1

  run bash -c 'source $TEMP_LIBSH_PATH; createFiles "$file_name" "$number_of_command" "$numbering_position" "$start_numbering_from"'
  echo "OUTPUT: <$output>"

  assert_success

  assert_file_exists "5-my-file.txt"
  assert_file_exists "6-my-file.txt"
  assert_file_exists "7-my-file.txt"
  assert_file_exists "8-my-file.txt"
  assert_file_exists "9-my-file.txt"

}