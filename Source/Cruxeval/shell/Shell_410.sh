#!/bin/bash
# $1 is a space-separated list
f() {
    nums=($1)
    a=0
    for i in ${!nums[@]}; do
        nums=("${nums[@]:0:$i}" "${nums[a]}" "${nums[@]:$i}")
        ((a++))
    done
    echo "${nums[@]}"
}

candidate() {
    f "$@"
}

set -e
run_test() {
    [[ $(candidate "1 3 -1 1 -2 6") = "1 1 1 1 1 1 1 3 -1 1 -2 6" ]]
}

run_test
