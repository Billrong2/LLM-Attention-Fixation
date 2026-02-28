#!/bin/bash
# $1 is a string
# $2 is a string
f() {
    if [[ $2 == $1* ]]; then
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
    [[ $(candidate "123" "123eenhas0") = "true" ]]
}

run_test
