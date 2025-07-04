input_test_files=$1

# making --filter-tags if filters
if [[ ! -z "$input_test_files" ]]; then
    test_files_arr=(${input_test_files// / })
    echo "Filters:"
    for filter in "${test_files_arr[@]}"; do
    echo "- $filter"
    filter_tests+=" --filter-tags $filter"
    done
fi

if [[ ! -z "$filter_tests" ]]; then 
    bats $filter_tests src/tests/test.bats
else
    bats src/tests/test.bats
fi