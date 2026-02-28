#!/bin/bash
# $1 is a string
f() {
    reversed_str=""
    for (( i=${#1}-1; i>=0; i-- )); do
        char="${1:$i:1}"
        if [[ $char =~ [0-9] ]]; then
            reversed_str="${reversed_str}${char}"
        fi
    done
    echo $reversed_str
}

candidate() {
    f "$@"
}

set -e
run_test() {
    [[ $(candidate "--4yrw 251-//4 6p") = "641524" ]]
}

run_test
