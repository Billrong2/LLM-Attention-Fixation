#!/bin/bash
# $1 is a newline-separated, space-separated list
f() {
    phone_code="+353"
    result=()
    while IFS= read -r line; do
        message=($line)
        message+=($(echo $phone_code | grep -o .))
        result+=("$(IFS=\;; echo "${message[*]}")")
    done <<< "$1"
    echo "${result[*]// /. }"
}

candidate() {
    f "$@"
}

set -e
run_test() {
    [[ $(candidate "Marie Nelson Oscar") = "Marie;Nelson;Oscar;+;3;5;3" ]]
}

run_test
