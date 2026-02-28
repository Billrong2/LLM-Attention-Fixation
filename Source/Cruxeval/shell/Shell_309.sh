#!/bin/bash
# $1 is a string
# $2 is a string
f() {
    local text="$1"
    local suffix="$2"
    text="${text}${suffix}"
    while [ "${text: -${#suffix}}" = "${suffix}" ]; do
        text="${text: 0: -1}"
    done
    echo "$text"
}

candidate() {
    f "$@"
}

set -e
run_test() {
    [[ $(candidate "faqo osax f" "f") = "faqo osax " ]]
}

run_test
