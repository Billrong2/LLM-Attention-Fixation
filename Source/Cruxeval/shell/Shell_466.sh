#!/bin/bash
# $1 is a string
f() {
    length=${#1}
    index=0
    while [ $index -lt $length ] && [ "${1:$index:1}" = " " ]; do
        index=$((index+1))
    done
    echo "${1:index:5}"
}

candidate() {
    f "$@"
}

set -e
run_test() {
    [[ $(candidate "-----	\n	th\n-----") = "-----" ]]
}

run_test
