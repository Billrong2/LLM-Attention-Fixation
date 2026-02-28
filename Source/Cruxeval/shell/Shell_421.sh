#!/bin/bash
# $1 is a string
# $2 is an integer
f() {
    if [ ${#1} -lt $2 ]; then
        echo $1
    else
        echo ${1:$2}
    fi
}

candidate() {
    f "$@"
}

set -e
run_test() {
    [[ $(candidate "try." "5") = "try." ]]
}

run_test
