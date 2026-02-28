#!/bin/bash
# $1 is a string
f() {
    if [[ $1 == *[[:lower:]]* ]]; then
        echo $1
    else
        echo $(echo $1 | rev)
    fi
}

candidate() {
    f "$@"
}

set -e
run_test() {
    [[ $(candidate "ykdfhp") = "ykdfhp" ]]
}

run_test
