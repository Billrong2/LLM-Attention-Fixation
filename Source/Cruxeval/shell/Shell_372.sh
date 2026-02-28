#!/bin/bash
# $1 is a space-separated list
# $2 is an integer
f() {
    list_=($1)
    num=$2
    temp=()
    
    for i in "${list_[@]}"; do
        for ((j=0; j<num/2; j++)); do
            temp+=("$i,")
        done
    done
    echo "${temp[@]}"
}

candidate() {
    f "$@"
}

set -e
run_test() {
    [[ $(candidate "v" "1") = "" ]]
}

run_test
