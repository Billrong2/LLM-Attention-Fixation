#!/bin/bash
# $1 is a space-separated list
f() {
    array=($1)
    zero_len=$(( (${#array[@]} - 1) % 3 ))
    for ((i=0; i<zero_len; i++)); do
        array[i]=0
    done
    for ((i=zero_len+1; i<${#array[@]}; i+=3)); do
        array[i]=0
        array[i+1]=0
        array[i+2]=0
    done
    echo "${array[@]}"
}

candidate() {
    f "$@"
}

set -e
run_test() {
    [[ $(candidate "9 2") = "0 2" ]]
}

run_test
