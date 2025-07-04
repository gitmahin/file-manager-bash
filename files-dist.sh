# !/bin/bash

shopt -s extglob  

example_core="example-core"
example_npm="example-npm"
example_zenity="example-zenity"

[[ ! -d "$example_core" ]] && mkdir -p "$example_core/src/tests"
[[ ! -d "$example_npm" ]] && mkdir -p "$example_npm/src/tests"
[[ ! -d "$example_zenity" ]] && mkdir -p "$example_zenity/src/tests"

if [[ -d "$example_core" ]]; then
    cp -r "src" "$example_core/"
    cp !(*-dist).sh "$example_core/"
    cp ".gitmodules" "$example_core/"
fi

if [[ -d "$example_npm" ]]; then
    cp "src/"*.sh "$example_npm/src/"
    cp !(*-dist).sh "$example_npm/"
    cp "src/tests/"*.bats "$example_npm/src/tests/"

    read -p ""
    echo "# Write custom install.sh commmands for npm" > install.sh
fi

if [[ -d "$example_zenity" ]]; then
    cp -r "src" "$example_zenity/"
    cp !(*-dist).sh "$example_zenity/"
    cp ".gitmodules" "$example_zenity/"
fi