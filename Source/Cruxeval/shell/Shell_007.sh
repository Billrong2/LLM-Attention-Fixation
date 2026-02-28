#!/bin/bash
# $1 is a $List
f() {
    original=("${!1}")  # Copy the input list
    while [ "${#1}" -gt 1 ]; do
        unset "$1[${#1}-1]"  # Remove the last element
        for i in $(seq 0 $(( ${#1} - 1 ))); do
            unset "$1[$i]"  # Remove all elements
        done
    done
    
    eval "$1=(${original[@]})"  # Restore the original list
    if [ "${#1}" -gt 0 ]; then
        unset "$1[0]"  # Remove the first element
    fi
}

candidate() {
    f "$@"
}

set -e
run_test() {
    [[ $(candidate "") = "" ]]
}

run_test
