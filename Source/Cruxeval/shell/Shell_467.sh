#!/bin/bash
# $1 is a two column CSV in key,value order
f() {
    input=$(echo "$1" | tr ',' '\n')
    declare -A copy
    while IFS=',' read -r key value; do
        copy[$key]+="$value "
    done <<<"$input"
    
    declare -A newDict
    for key in "${!copy[@]}"; do
        values=(${copy[$key]})
        newDict[$key]=${#values[@]}
    done
    
    for key in "${!newDict[@]}"; do
        echo "$key:${newDict[$key]}"
    done
}

candidate() {
    f "$@"
}

set -e
run_test() {
    [[ $(candidate "") = "" ]]
}

run_test
