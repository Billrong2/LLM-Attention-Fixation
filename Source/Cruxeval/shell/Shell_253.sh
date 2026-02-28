#!/bin/bash
# $1 is a string
# $2 is a string
f() {
    length=${#2}
    if [ "${2}" == "${1:0:${length}}" ]; then
        echo "${1:${length}}"
    else
        echo "$1"
    fi
}

candidate() {
    f "$@"
}

set -e
run_test() {
    [[ $(candidate "kumwwfv" "k") = "umwwfv" ]]
}

run_test
