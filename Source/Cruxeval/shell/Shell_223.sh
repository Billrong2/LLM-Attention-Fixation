#!/bin/bash
# $1 is a space-separated list
# $2 is an integer
f() {
    local array=($1)
    local target=$2
    local count=0
    local i=1
    for ((j=1; j<${#array[@]}; j++)); do
        if (( ${array[j]} > ${array[j-1]} && ${array[j]} <= target )); then
            (( count += i ))
        elif (( ${array[j]} <= ${array[j-1]} )); then
            i=1
        else
            (( i += 1 ))
        fi
    done
    echo $count
}

candidate() {
    f "$@"
}

set -e
run_test() {
    [[ $(candidate "1 2 -1 4" "2") = "1" ]]
}

run_test
