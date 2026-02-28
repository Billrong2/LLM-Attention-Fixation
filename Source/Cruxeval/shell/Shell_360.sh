#!/bin/bash
# $1 is a string
# $2 is an integer
f() {
    text=$1
    n=$2
    if [ ${#text} -le 2 ]; then
        echo $text
    else
        leading_chars=$(printf "%-${n}s" "${text:0:1}")
        echo "${leading_chars}${text:1:-1}${text: -1}"
    fi
}

candidate() {
    f "$@"
}

set -e
run_test() {
    [[ $(candidate "g" "15") = "g" ]]
}

run_test
