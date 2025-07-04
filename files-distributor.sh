# !/bin/bash

example_core="example-core"
example_npm="example-npm"
example_zenity="example-zenity"

[[ -d "$example_core" ]] && mkdir -p "$example_core/src/tests"

# cd example-npm 
# mkdir src
# mkdir src/tests
# cd src
# cd ../../
# cp example-core/src/*.sh example-npm/src/
# cp example-core/src/tests/test.bats example-npm/src/tests/