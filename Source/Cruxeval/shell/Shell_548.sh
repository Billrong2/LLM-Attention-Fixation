#!/bin/bash
# $1 is a string
# $2 is a string
f() {
    if [[ -n $1 && -n $2 && $1 == *$2 ]]; then
        echo ${1%$2}
    else
        echo $1
    fi
}

candidate() {
    f "$@"
}

set -e
run_test() {
    [[ $(candidate "spider" "ed") = "spider" ]]
}

run_test
