#!/bin/bash
# $1 is a space-separated list
f() {
    s=($1)
    while [ ${#s[@]} -gt 1 ]; do
        s=()
        s+=( ${#s[@]} )
    done
    echo ${s[@]: -1}
}

candidate() {
    f "$@"
}

set -e
run_test() {
    [[ $(candidate "6 1 2 3") = "0" ]]
}

run_test
