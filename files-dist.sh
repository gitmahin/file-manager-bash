# !/bin/bash

# extended globbing
shopt -s extglob  

askToContinue() {
    read -p "Do you want to override $1": options
    [[ "$options" != [yY] ]] && return 1
    return 0
}

emptyCleanUp(){
    [[ -d "$1" && -z "$(ls -a "$1" | grep sh)" ]] && { rm -rf "$1"; echo "No .sh file found! Removing $1"; }
}

example_core="example-core"
example_npm="example-npm"
example_zenity="example-zenity"

[[ ! -d "$example_core" ]] && mkdir -p "$example_core/src/tests"
[[ ! -d "$example_npm" ]] && mkdir -p "$example_npm/src/tests"
[[ ! -d "$example_zenity" ]] && mkdir -p "$example_zenity/src/tests"

# EXAMPLE CORE
if [[ -d "$example_core" ]]; then
    askToContinue "$example_core"

    if [[ $? == 0 ]]; then
        cp -r "src" "$example_core/"
        cp !(*-dist).sh "$example_core/"
        cp ".gitmodules" "$example_core/"
    fi
fi

# EXAMPLE WITH NPM
if [[ -d "$example_npm" ]]; then

    askToContinue "$example_npm"
    
    if [[ $? == 0 ]]; then
        cp "src/"*.sh "$example_npm/src/"
        cp !(*-dist).sh "$example_npm/"
        cp "src/tests/"*.bats "$example_npm/src/tests/"

        read -p "Do you want to override install.sh file for npm? [y/n]": options
        [[ "$options" == [yY] ]] && ( echo "# Write custom install.sh commmands for npm" > "$example_npm/install.sh" )
    fi
    
fi

# EXAMPLE WITH ZENITY
if [[ -d "$example_zenity" ]]; then

    askToContinue "$example_zenity"

    if [[ $? == 0 ]]; then
        cp -r "src" "$example_zenity/"
        cp !(*-dist).sh "$example_zenity/"
        cp ".gitmodules" "$example_zenity/"
    fi
fi

emptyCleanUp "$example_core"
emptyCleanUp "$example_npm"
emptyCleanUp "$example_zenity"