#!/bin/bash
# $1 is a string
# $2 is a string
f() {
    a=()
    if [[ ${1:0:1} == ${2:0:1} && ${1: -1} == ${2: -1} ]]; then
        a+=("$1")
        a+=("$2")
    else
        a+=("$2")
        a+=("$1")
    fi
    echo "${a[@]}"
}

candidate() {
    f "$@"
}

set -e
run_test() {
    [[ $(candidate "ab" "xy") = "xy ab" ]]
}

run_test
