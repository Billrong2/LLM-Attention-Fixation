#!/bin/bash
# $1 is a string
# $2 is a string
f() {
    if [[ $1 == *"$2"* ]]; then
        echo "true"
    else
        echo "false"
    fi
}

candidate() {
    f "$@"
}

set -e
run_test() {
    [[ $(candidate "booty boot-boot bootclass" "k") = "false" ]]
}

run_test
