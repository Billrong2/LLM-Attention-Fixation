#!/bin/bash
# $1 is a space-separated list
# $2 is an integer
f() {
    read -r -a chemicals <<< "$1"
    num=$2
    
    fish=("${chemicals[@]:1}")
    
    chemicals=($(echo "${chemicals[@]}" | tac -s' '))
    
    for (( i=0; i<num; i++ )); do
        fish+=("${chemicals[1]}")
        unset chemicals[1]
        chemicals=($(echo "${chemicals[@]}" | tac -s' '))
    done
    
    chemicals=($(echo "${chemicals[@]}" | tac -s' '))
    
    echo "${chemicals[@]}"
}

candidate() {
    f "$@"
}

set -e
run_test() {
    [[ $(candidate "lsi s t t d" "0") = "lsi s t t d" ]]
}

run_test
