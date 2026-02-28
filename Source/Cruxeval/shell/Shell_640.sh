#!/bin/bash
# $1 is a string
f() {
    a=0
    if [[ $1 =~ ${1:1} ]]; then
        ((a++))
    fi
    for ((i=0; i<${#1}-1; i++)); do
        if [[ ${1:$i+1} =~ ${1:$i:1} ]]; then
            ((a++))
        fi
    done
    echo "$a"
}

candidate() {
    f "$@"
}

set -e
run_test() {
    [[ $(candidate "3eeeeeeoopppppppw14film3oee3") = "18" ]]
}

run_test
