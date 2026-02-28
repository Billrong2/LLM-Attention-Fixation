#!/bin/bash
# $1 is a string
# $2 is a string
f() {
    text=$1
    sub=$2

    if [[ "$text" == *"$sub"* ]]; then
        echo ${#text}
    else
        echo 0
    fi
}

candidate() {
    f "$@"
}

set -e
run_test() {
    [[ $(candidate "dorfunctions" "2") = "0" ]]
}

run_test
