#!/bin/bash
# $1 is a space-separated list
f() {
    nums=($1)
    for i in ${!nums[@]}; do
        value=$((${nums[$i]}**2))
        nums=("${nums[@]:0:$i+1}" "$value" "${nums[@]:$i+1}")
    done
    echo "${nums[@]}"
}

candidate() {
    f "$@"
}

set -e
run_test() {
    [[ $(candidate "1 2 4") = "1 1 1 1 2 4" ]]
}

run_test
