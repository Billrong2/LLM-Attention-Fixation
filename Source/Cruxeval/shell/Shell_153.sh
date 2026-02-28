#!/bin/bash
# $1 is a string
# $2 is a string
# $3 is an integer
f() {
    text=$1
    suffix=$2
    str_num=$3
    if [[ "$text" == *"$suffix$str_num" ]]; then
        echo true
    else
        echo false
    fi
}

candidate() {
    f "$@"
}

set -e
run_test() {
    [[ $(candidate "friends and love" "and" "3") = "false" ]]
}

run_test
