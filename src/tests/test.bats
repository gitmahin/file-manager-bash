#!/usr/bin/env bats

export BATS_TMPDIR=""

setup(){
  load 'test_helper/bats-support/load'
  load 'test_helper/bats-assert/load'

  DIR="$(cd "$( dirname "$BATS_TEST_FILENAME" )" >/dev/null 2>&1 && pwd)"
  # make executables in src/ visible to PATH
  PATH="$DIR/../src:$PATH"

  current_dir=$(pwd)
  BATS_TMPDIR=$(mktemp -d -t bats-test-XXXXXX)
  export MAIN_ENTRY="${BATS_TEST_DIRNAME}/../lib.sh"
  cd "$BATS_TMPDIR" || exit 1
 
}

# bats test_tags=create-files
@test "Should copy and create files serially without custom output file name" {
  export filename="test.txt"
  export number_of_command=3
  run touch "$filename"

  run bash -c 'source "$MAIN_ENTRY"; copyNCreateFiles "$filename" "" "$number_of_command"'
  echo "ERROR DETAILS: <$output>"
  [ "$status" -eq 0 ]

}

