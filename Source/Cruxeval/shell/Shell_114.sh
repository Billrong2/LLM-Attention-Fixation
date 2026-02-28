#!/bin/bash
# $1 is a string
# $2 is a string
f() {
    text=$1
    sep=$2
    result=()
    while [[ "${text}" == *${sep}* ]]; do
        result+=("${text%%${sep}*}")
        text="${text#*${sep}}"
    done
    result+=("${text}")
    echo "${result[@]}"
}

candidate() {
    f "$@"
}

set -e
run_test() {
    [[ $(candidate "a-.-.b" "-.") = "a  b" ]]
}

run_test
