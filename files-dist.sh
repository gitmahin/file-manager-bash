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

examples="examples"
example_npm="example-npm"
example_zenity="example-zenity"

[[ ! -d "$examples/$example_npm" ]] && mkdir -p "$examples/$example_npm/src/tests"
[[ ! -d "$examples/$example_zenity" ]] && mkdir -p "$examples/$example_zenity/src/tests"

# EXAMPLE WITH NPM
if [[ -d "$examples/$example_npm" ]]; then

    [[ -z "$(ls -a "$examples/$example_npm" | grep sh)" ]] && (askToContinue "$example_npm")
    
    if [[ $? == 0 ]]; then
        cp "src/"*.sh "$examples/$example_npm/src/"
        cp !(*-dist).sh "$examples/$example_npm/"
        cp "src/tests/"*.bats "$examples/$example_npm/src/tests/"

        read -p "Do you want to override install.sh file for npm? [y/n]": options
        [[ "$options" == [yY] ]] && ( echo "# Write custom install.sh commmands for npm" > "$examples/$example_npm/install.sh" )
    fi
    
fi

# EXAMPLE WITH ZENITY
if [[ -d "$examples/$example_zenity" ]]; then
   
    [[ -z "$(ls -a "$examples/$example_zenity" | grep sh)" ]] && (askToContinue "$example_zenity")

    if [[ $? == 0 ]]; then
        cp -r "src" "$examples/$example_zenity/"
        cp !(*-dist).sh "$examples/$example_zenity/"
        cp ".gitmodules" "$examples/$example_zenity/"
    fi
fi

emptyCleanUp "$examples/$example_npm"
emptyCleanUp "$examples/$example_zenity"