#!/bin/bash
# $1 is a string
f() {
    result=""
    for ((i=${#1}-1; i>=0; i--)); do
        result="$result${1:i:1}"
    done
    echo $result
}

candidate() {
    f "$@"
}

set -e
run_test() {
    [[ $(candidate "was,") = ",saw" ]]
}

run_test
