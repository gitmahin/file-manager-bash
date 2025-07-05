# !/bin/bash

# getting filters from input
input_test_files=$1

if [[ ! -e "/usr/local/bin/bats" ]]; then
    echo "bats-core not found! Installing..."
    chmod -v 755 "install.dev.sh"
    bash "install.dev.sh"
fi

# making --filter-tags if filters
if [[ ! -z "$input_test_files" ]]; then
    # spliting string via space and store in array -> test_files_arr
    test_files_arr=(${input_test_files// / })
    echo "Filters:"
    for filter in "${test_files_arr[@]}"; do
        echo "- $filter"
        # making a proper bats --filter-tags
        filter_tests+=" --filter-tags $filter"
        # output: --filter-tags tag-1 tag-2 tag-3
    done
fi

if [[ ! -z "$filter_tests" ]]; then
    # dont wrap $filter_tests in a string! 
    # As Bats expects --filter-tags as multiple separate arguments (e.g. tag-1 tag-2),
    bats $filter_tests src/tests
else
    bats src/tests
fi
