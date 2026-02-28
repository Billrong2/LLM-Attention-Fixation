#!/bin/bash
# $1 is a string
f() {
    n=$(expr index "$1" '8')
    echo $(printf 'x0%.0s' $(seq 1 $((n-1))))
}

candidate() {
    f "$@"
}

set -e
run_test() {
    [[ $(candidate "sa832d83r xd 8g 26a81xdf") = "x0x0" ]]
}

run_test
