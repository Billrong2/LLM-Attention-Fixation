#!/bin/bash
# $1 is a space-separated list
# $2 is an integer
# $3 is an integer
f() {
    nums=($1)
    pos=$2
    value=$3
    nums=(${nums[@]:0:pos} $value ${nums[@]:pos})
    echo "${nums[@]}"
}

candidate() {
    f "$@"
}

set -e
run_test() {
    [[ $(candidate "3 1 2" "2" "0") = "3 1 0 2" ]]
}

run_test
