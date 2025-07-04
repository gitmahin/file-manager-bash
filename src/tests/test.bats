#!/usr/bin/env bats

export BATS_TMPDIR=""

setup(){
  load 'test_helper/bats-support/load'
  load 'test_helper/bats-assert/load'

  DIR="$(cd "$( dirname "$BATS_TEST_FILENAME" )" >/dev/null 2>&1 && pwd)"
  PATH="$DIR/../src:$PATH"

  current_dir=$(pwd)
  BATS_TMPDIR=$(mktemp -d -t bats-test-XXXXXX)
  export TEMP_LIBSH_PATH="${BATS_TEST_DIRNAME}/../lib.sh"
}

# teardown() {
  
# }

# bats test_tags=create-files
@test "Should copy and create files 2 to 4 without custom output file-name" {
  export filename="test.txt"
  export number_of_command=3
  cd "$BATS_TMPDIR" || exit 1
  run touch "$filename"

  run bash -c 'source $TEMP_LIBSH_PATH; copyNCreateFiles "$filename" "" "$number_of_command"'
  echo "ERROR DETAILS: <$output>"
  [ "$status" -eq 0 ]
  
  assert_line "Searching... [test.txt]"
  assert_line "Created: test-2.txt"
  assert_line "Created: test-3.txt"
  assert_line "Created: test-4.txt"
}


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