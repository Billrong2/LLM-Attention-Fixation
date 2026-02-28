#!/bin/bash
# $1 is a space-separated list
# $2 is an integer
f() {
    nums=($1)
    unset nums[$2]
    echo "${nums[@]}"
}

candidate() {
    f "$@"
}

set -e
run_test() {
    [[ $(candidate "35 45 3 61 39 27 47" "0") = "45 3 61 39 27 47" ]]
}

run_test
