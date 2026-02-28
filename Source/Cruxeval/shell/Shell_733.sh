#!/bin/bash
# $1 is a string
f() {
    length=$(( ${#1} / 2 ))
    left_half=${1:0:length}
    right_half=$(echo ${1:length} | rev)
    echo $left_half$right_half
}

candidate() {
    f "$@"
}

set -e
run_test() {
    [[ $(candidate "n") = "n" ]]
}

run_test
