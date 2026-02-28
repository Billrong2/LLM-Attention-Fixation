#!/bin/bash
# $1 is a space-separated list
# $2 is an integer
# $3 is an integer
f() {
    arr=($1)
    arr=("${arr[@]:0:$2-1}" "${arr[@]:$2}")
    arr=("${arr[@]:0:$3-1}" "${arr[@]:$3}")
    echo "${arr[@]}"
}

candidate() {
    f "$@"
}

set -e
run_test() {
    [[ $(candidate "1 5 2 3 6" "2" "4") = "1 2 3" ]]
}

run_test
