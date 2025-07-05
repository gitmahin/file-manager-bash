#!/usr/bin/env bats

bats_load_safe "helper.bash"

setup(){
  setup_testing_ground
  setup_file_assertion
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