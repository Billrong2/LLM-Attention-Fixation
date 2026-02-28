#!/bin/bash
# $1 is a space-separated list
f() {
    a=($1)
    b=("${a[@]}")
    for ((k=0; k<${#a[@]}-1; k+=2)); do
        b=("${b[@]:0:k+1}" "${b[k]}" "${b[@]:k+1}")
    done
    b+=(${b[0]})
    echo "${b[@]}"
}

candidate() {
    f "$@"
}

set -e
run_test() {
    [[ $(candidate "5 5 5 6 4 9") = "5 5 5 5 5 5 6 4 9 5" ]]
}

run_test
