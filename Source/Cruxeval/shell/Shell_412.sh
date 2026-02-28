#!/bin/bash
# $1 is an integer
# $2 is an integer
# $3 is an integer
f() {
    steps=($(seq $1 $3 $2))
    if [[ "${steps[@]}" =~ 1 ]]; then
        steps[-1]=$(( $2 + 1 ))
    fi
    echo ${#steps[@]}
}

candidate() {
    f "$@"
}

set -e
run_test() {
    [[ $(candidate "3" "10" "1") = "8" ]]
}

run_test
