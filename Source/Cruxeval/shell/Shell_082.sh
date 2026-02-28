#!/bin/bash
# $1 is a string
# $2 is a string
# $3 is a string
# $4 is a string
f() {
    if [[ $1 && $2 || $3 && $4 ]]; then
        echo $2
    else
        echo $4
    fi
}

candidate() {
    f "$@"
}

set -e
run_test() {
    [[ $(candidate "CJU" "BFS" "WBYDZPVES" "Y") = "BFS" ]]
}

run_test
