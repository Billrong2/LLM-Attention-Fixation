#!/bin/bash
# $1 is a string
f() {
    number=0
    for ((i=0; i<${#1}; i++)); do
        if [[ ${1:i:1} =~ [0-9] ]]; then
            ((number++))
        fi
    done
    echo $number
}

candidate() {
    f "$@"
}

set -e
run_test() {
    [[ $(candidate "Thisisastring") = "0" ]]
}

run_test
