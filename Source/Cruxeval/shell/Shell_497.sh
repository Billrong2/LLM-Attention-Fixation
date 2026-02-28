#!/bin/bash
# $1 is an integer
f() {
    n=$1
    b=($(echo $n | grep -o .))
    for ((i=2; i<${#b[@]}; i++)); do
        b[i]="${b[i]}+"
    done
    echo "${b[@]}"
}

candidate() {
    f "$@"
}

set -e
run_test() {
    [[ $(candidate "44") = "4 4" ]]
}

run_test
