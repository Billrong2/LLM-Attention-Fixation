#!/bin/bash
# $1 is a string
# $2 is an integer
f() {
    text=$1
    n=$2
    length=${#text}
    echo ${text:$((length*(n%4))):$length}
}

candidate() {
    f "$@"
}

set -e
run_test() {
    [[ $(candidate "abc" "1") = "" ]]
}

run_test
