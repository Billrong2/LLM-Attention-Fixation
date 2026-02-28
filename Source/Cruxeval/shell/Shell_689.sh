#!/bin/bash
# $1 is a space-separated list
f() {
    local arr=($1)
    local count=${#arr[@]}
    local sub=("${arr[@]}")
    for (( i=0; i<count; i+=2 )); do
        sub[i]=$(( ${arr[i]} * 5 ))
    done
    echo "${sub[@]}"
}

candidate() {
    f "$@"
}

set -e
run_test() {
    [[ $(candidate "-3 -6 2 7") = "-15 -6 10 7" ]]
}

run_test
