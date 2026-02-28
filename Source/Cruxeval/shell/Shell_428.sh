#!/bin/bash
# $1 is a space-separated list
f() {
    nums=($1)
    new_nums=()
    for ((i=0; i<${#nums[@]}; i++)); do
        if (( i % 2 == 0 )); then
            new_nums+=(${nums[i]}*${nums[i+1]})
        fi
    done
    echo "${new_nums[@]}"
}

candidate() {
    f "$@"
}

set -e
run_test() {
    [[ $(candidate "") = "" ]]
}

run_test
