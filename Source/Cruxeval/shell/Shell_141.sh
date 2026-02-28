#!/bin/bash
# $1 is a space-separated list
f() {
    input_array=($1)
    output_array=()
    for item in "${input_array[@]}"; do
        count=$(grep -o "\<$item\>" <<< "$1" | wc -l)
        output_array+=($count)
    done
    echo "${output_array[@]}"
}

candidate() {
    f "$@"
}

set -e
run_test() {
    [[ $(candidate "k x c x x b l f r n g") = "1 3 1 3 3 1 1 1 1 1 1" ]]
}

run_test
