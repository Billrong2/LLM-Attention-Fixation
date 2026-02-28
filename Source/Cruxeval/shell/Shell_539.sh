#!/bin/bash
# $1 is a space-separated list
f() {
    array=$1
    array_copy=$1
    c=$1

    # Add "_" to the end of array until it's different from array_copy
    while true; do
        c+=("_")
        # Check if arrays are different
        if [[ "${c[@]}" != "${array_copy[@]}" ]]; then
            # Replace the first occurrence of "_" in array_copy with an empty string
            for i in "${!array_copy[@]}"; do 
                if [[ ${array_copy[$i]} == "_" ]]; then
                    array_copy[$i]=""
                    break
                fi
            done
            break
        fi
    done

    echo "${array_copy[@]}"
}

candidate() {
    f "$@"
}

set -e
run_test() {
    [[ $(candidate "") = "" ]]
}

run_test
