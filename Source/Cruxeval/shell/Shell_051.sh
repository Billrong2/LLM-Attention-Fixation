#!/bin/bash
# $1 is an integer
f() {
    s=$(printf "%0.s<" {1..10})
    if [ $(( $1 % 2 )) -eq 0 ]; then
        echo $s
    else
        echo $(( $1 - 1 ))
    fi
}

candidate() {
    f "$@"
}

set -e
run_test() {
    [[ $(candidate "21") = "20" ]]
}

run_test
