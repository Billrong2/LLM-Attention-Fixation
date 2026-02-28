#!/bin/bash
# $1 is a space-separated list
f() {
    input=($1)
    output=("${input[@]}")
    tmp=()
    for ((i=${#output[@]}-1; i>=0; i-=2))
    do
        tmp+=(${output[i]})
    done
    for ((i=0; i<${#output[@]}; i+=2))
    do
        tmp+=(${output[i]})
    done
    echo ${tmp[@]}
}

candidate() {
    f "$@"
}

set -e
run_test() {
    [[ $(candidate "") = "" ]]
}

run_test
