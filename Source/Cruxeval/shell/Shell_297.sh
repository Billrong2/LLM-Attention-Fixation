#!/bin/bash
# $1 is an integer
f() {
    if [ $1 -gt 0 ] && [ $1 -lt 1000 ] && [ $1 -ne 6174 ]; then
        echo "Half Life"
    else
        echo "Not found"
    fi
}

candidate() {
    f "$@"
}

set -e
run_test() {
    [[ $(candidate "6173") = "Not found" ]]
}

run_test
