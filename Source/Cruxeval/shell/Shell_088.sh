#!/bin/bash
# $1 is a string
# $2 is a string
f() {
    if [[ $2 == *$1 ]]; then
        echo ${2%$1}
    else
        echo $2
    fi
}

candidate() {
    f "$@"
}

set -e
run_test() {
    [[ $(candidate "he" "hello") = "hello" ]]
}

run_test
