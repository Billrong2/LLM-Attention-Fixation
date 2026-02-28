#!/bin/bash
# $1 is a space-separated list
# $2 is an integer
# $3 is an integer
f() {
    nums=($1)
    spot=$2
    idx=$3
    nums=("${nums[@]::$spot}" "$idx" "${nums[@]:$spot}")
    echo "${nums[@]}"
}

candidate() {
    f "$@"
}

set -e
run_test() {
    [[ $(candidate "1 0 1 1" "0" "9") = "9 1 0 1 1" ]]
}

run_test
