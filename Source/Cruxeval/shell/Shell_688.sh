#!/bin/bash
# $1 is a space-separated list
f() {
    read -a arr <<< "$1"
    new_arr=()
    for i in "${arr[@]}"; do
        if ! [[ " ${new_arr[*]} " == *" $i "* ]]; then
            new_arr+=("$i")
        fi
    done
    echo "${new_arr[@]}"
}

candidate() {
    f "$@"
}

set -e
run_test() {
    [[ $(candidate "3 1 9 0 2 0 8") = "3 1 9 0 2 8" ]]
}

run_test
