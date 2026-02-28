#!/bin/bash
# $1 is a string
# $2 is a string
f() {
    if [[ $2 == /* ]]; then
        echo $1${2:1}
    else
        echo $1
    fi
}

candidate() {
    f "$@"
}

set -e
run_test() {
    [[ $(candidate "hello.txt" "/") = "hello.txt" ]]
}

run_test
