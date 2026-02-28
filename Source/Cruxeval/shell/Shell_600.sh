#!/bin/bash
# $1 is a space-separated list
f() {
    local array=($1)
    local just_ns=()
    for num in "${array[@]}"; do
        just_ns+=($(printf "%0.sn" $(seq 1 $num)))
    done
    local final_output=("${just_ns[@]}")
    echo "${final_output[@]}"
}

candidate() {
    f "$@"
}

set -e
run_test() {
    [[ $(candidate "") = "" ]]
}

run_test
