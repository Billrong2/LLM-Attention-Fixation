#!/bin/bash
# $1 is a string
f() {
    a=('')
    b=''
    for ((i=0; i<${#1}; i++)); do
        if [[ ! ${1:i:1} =~ [[:space:]] ]]; then
            a+=("$b")
            b=''
        else
            b+="${1:i:1}"
        fi
    done
    echo ${#a[@]}
}

candidate() {
    f "$@"
}

set -e
run_test() {
    [[ $(candidate "       ") = "1" ]]
}

run_test
