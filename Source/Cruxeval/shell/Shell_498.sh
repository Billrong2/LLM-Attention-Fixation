#!/bin/bash
# $1 is a space-separated list
# $2 is an integer
# $3 is an integer
f() {
    nums=($1)
    nums=("${nums[@]:0:$2}" $3 "${nums[@]:$2}")
    echo ${nums[@]}
}

candidate() {
    f "$@"
}

set -e
run_test() {
    [[ $(candidate "2 2 2 3 3" "2" "3") = "2 2 3 2 3 3" ]]
}

run_test
