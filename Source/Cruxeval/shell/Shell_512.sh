#!/bin/bash
# $1 is a string
f() {
    len=${#1}
    zeros=$(echo $1 | tr -cd '0' | wc -c)
    ones=$(echo $1 | tr -cd '1' | wc -c)
    if [ $(($zeros + $ones)) -eq $len ]; then
        echo true
    else
        echo false
    fi
}

candidate() {
    f "$@"
}

set -e
run_test() {
    [[ $(candidate "102") = "false" ]]
}

run_test
