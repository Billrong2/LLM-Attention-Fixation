#!/bin/bash
# $1 is a string
f() {
    if [[ $1 =~ ^[0-9]+$ ]]; then
        echo "int"
    elif [[ $1 =~ ^[0-9]+\.[0-9]+$ ]]; then
        echo "float"
    elif [[ $1 =~ ^\ +$ ]]; then
        echo "str"
    elif [[ ${#1} -eq 1 ]]; then
        echo "char"
    else
        echo "tuple"
    fi
}

candidate() {
    f "$@"
}

set -e
run_test() {
    [[ $(candidate " 99 777") = "tuple" ]]
}

run_test
