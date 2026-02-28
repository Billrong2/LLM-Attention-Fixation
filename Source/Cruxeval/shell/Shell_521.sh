#!/bin/bash
# $1 is a space-separated list
f() {
    nums=($1)
    m=0
    for num in ${nums[@]}; do
        if ((num > m)); then
            m=$num
        fi
    done

    for ((i=0; i<m; i++)); do
        nums=($(echo ${nums[@]} | tr ' ' '\n' | tac))
    done
    
    echo ${nums[@]}
}

candidate() {
    f "$@"
}

set -e
run_test() {
    [[ $(candidate "43 0 4 77 5 2 0 9 77") = "77 9 0 2 5 77 4 0 43" ]]
}

run_test
