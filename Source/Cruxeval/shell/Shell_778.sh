#!/bin/bash
# $1 is a string
# $2 is a string
f() {
    if [[ $2 == $1* ]]; then
        echo $2
    else
        echo $1$2
    fi
}

candidate() {
    f "$@"
}

set -e
run_test() {
    [[ $(candidate "mjs" "mjqwmjsqjwisojqwiso") = "mjsmjqwmjsqjwisojqwiso" ]]
}

run_test
