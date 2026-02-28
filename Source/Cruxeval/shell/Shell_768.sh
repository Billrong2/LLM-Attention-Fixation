#!/bin/bash
# $1 is a string
# $2 is a string
f() {
    if [[ $1 == $2* ]]; then
        echo $1
    else
        echo $2$(f $1 ${2: -2: -1})
    fi
}

candidate() {
    f "$@"
}

set -e
run_test() {
    [[ $(candidate "abba" "bab") = "bababba" ]]
}

run_test
