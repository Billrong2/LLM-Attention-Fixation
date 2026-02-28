#!/bin/bash
# $1 is a string
f() {
    text=$1
    text_arr=()
    for ((j=0; j<${#text}; j++)); do
        text_arr+=("${text:j}")
    done
    echo "${text_arr[@]}"
}

candidate() {
    f "$@"
}

set -e
run_test() {
    [[ $(candidate "123") = "123 23 3" ]]
}

run_test
