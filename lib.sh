# !/bin/bash

copyNCreateFiles() {
    file_name=$1
    output_file_name=$2
    number_of_command=$3
    IFS="." read -r actual_file_name file_ext <<< "$file_name"
    for (( i=0; i < "$number_of_command"; i++ )); do
            # fallback output_file_name
            dest_file="${output_file_name:-"$actual_file_name"}-$((($i+2))).$file_ext"
            cp "$file_name" "$dest_file"
            echo "Created: $dest_file"
            [[ ! -e $dest_file ]] && return 1
    done
    return 0
}