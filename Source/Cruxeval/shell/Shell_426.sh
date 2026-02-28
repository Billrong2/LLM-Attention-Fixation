#!/bin/bash
# $1 is a space-separated list
# $2 is a $Any
# $3 is an integer
f() {
    numbers=($1)
    numbers=("${numbers[@]:0:$3}" "$2" "${numbers[@]:$3}")
    echo "${numbers[@]}"
}

candidate() {
    f "$@"
}

set -e
run_test() {
    [[ $(candidate "1 2 3" "8" "5") = "1 2 3 8" ]]
}

run_test
