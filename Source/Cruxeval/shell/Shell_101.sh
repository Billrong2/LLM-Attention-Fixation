#!/bin/bash
# $1 is a space-separated list
# $2 is an integer
# $3 is a $Any
f() {
    local array=($1)
    local i_num=$2
    local elem=$3
    array=("${array[@]:0:i_num}" "$elem" "${array[@]:i_num}")
    echo "${array[@]}"
}

candidate() {
    f "$@"
}

set -e
run_test() {
    [[ $(candidate "-4 1 0" "1" "4") = "-4 4 1 0" ]]
}

run_test
