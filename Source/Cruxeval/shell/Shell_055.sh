#!/bin/bash
# $1 is a space-separated list
f() {
    array_1=($1)
    array_2=()
    for i in "${array_1[@]}"; do
        if (( i > 0 )); then
            array_2+=( $i )
        fi
    done
    IFS=$'\n' array_2=($(sort -nr <<<"${array_2[*]}"))
    echo "${array_2[@]}"
}

candidate() {
    f "$@"
}

set -e
run_test() {
    [[ $(candidate "4 8 17 89 43 14") = "89 43 17 14 8 4" ]]
}

run_test
