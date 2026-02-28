#!/bin/bash
# $1 is a space-separated list
# $2 is an integer
f() {
    nums=($1)
    rmvalue=$2
    res=("${nums[@]}")
    while [[ " ${res[*]} " == *" $rmvalue "* ]]; do
        index=$(echo ${res[@]} | xargs -n1 echo | grep -n "\<$rmvalue\>" | cut -d: -f1)
        unset 'res[index-1]'
    done
    echo "${res[@]}"
}

candidate() {
    f "$@"
}

set -e
run_test() {
    [[ $(candidate "6 2 1 1 4 1" "5") = "6 2 1 1 4 1" ]]
}

run_test
