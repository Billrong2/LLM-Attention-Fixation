#!/bin/bash
# $1 is a space-separated list
# $2 is a space-separated list
f() {
    nums=($1)
    elements=($2)
    result=()
    for i in ${elements[@]}; do
        result+=(${nums[-1]})
        unset 'nums[${#nums[@]}-1]'
    done
    echo ${nums[@]}
}

candidate() {
    f "$@"
}

set -e
run_test() {
    [[ $(candidate "7 1 2 6 0 2" "9 0 3") = "7 1 2" ]]
}

run_test
