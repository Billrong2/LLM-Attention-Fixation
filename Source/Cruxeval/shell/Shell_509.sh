#!/bin/bash
# $1 is an integer
# $2 is an integer
f() {
    if [ $1 -ge 0 ]; then
        printf "%0${2}d\n" $1
    else
        printf "-%0${2}d\n" $((-1*$1))
    fi
}

candidate() {
    f "$@"
}

set -e
run_test() {
    [[ $(candidate "5" "1") = "5" ]]
}

run_test
