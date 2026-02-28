#!/bin/bash
# $1 is a string
# $2 is a string
f() {
    result=-1
    for ((i=${#1}; i>=0; i--)); do
        if [[ ${1:i} == $2 ]]; then
            result=$i
            break
        fi
    done
    echo $result
}

candidate() {
    f "$@"
}

set -e
run_test() {
    [[ $(candidate "345gerghjehg" "345") = "-1" ]]
}

run_test
