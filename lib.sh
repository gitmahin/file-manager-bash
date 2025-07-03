# !/bin/bash

copyNCreateFiles() {
    file_name=$1
    output_file_name=$2
    number_of_command=$3

    # getting full path of the file to avoid errors 
    echo "Searching... [$file_name]"
    file_location=$(find / -iname "$file_name" 2>/dev/null | head -n 1)

    [[ ! -e "$file_location" ]] && echo "File not found in this system"; exit 1

    # split by slash(/) and get the actual file 
    splitFileLocation=(${file_location//\// })
    
    # get the last elements from the $splitFileLocation array
    real_file=${splitFileLocation[-1]}

    IFS="." read -r extracted_file_name file_ext <<< "${output_file_name:-"$real_file"}"
    for (( i=0; i < "$number_of_command"; i++ )); do
            # fallback output_file_name
            dest_file="$extracted_file_name-$((($i+2))).$file_ext"
            cp "$file_name" "$dest_file"
            echo "Created: $dest_file"
            [[ ! -e $dest_file ]] && echo "Failed to create - $dest_file"; return 1
    done
    return 0
}

copyNCreateFolders() {
    folder_name=$1
    number_of_command=$2
    numbering_position="${3:-r}"

    for (( i=0; i < "$number_of_command"; i++ )); do

        if [[ "$numbering_position" == [lL] ]]; then
            left_nposition_file="$((($i+1)))-$folder_name"
            mkdir "$left_nposition_file"
            [[ ! -d "$left_nposition_file" ]] && echo "Failed to create - $left_nposition_file"; return 1
        fi

        if [[ "$numbering_position" == [rR] ]]; then
            right_nposition_file="$folder_name-$((($i+1)))"
            mkdir "$right_nposition_file"
               [[ ! -d "$right_nposition_file" ]] && echo "Failed to create - $right_nposition_file"; return 1
        fi
    done
    return 0
}