#!/bin/bash
# $1 is a string
# $2 is a newline-separated, space-separated list
f() {
    local line=$1
    local equalityMap=$2
    declare -A rs

    while IFS=' ' read -r key value; do
        rs["$key"]="$value"
    done <<< "$equalityMap"

    result=""
    for (( i=0; i<${#line}; i++ )); do
        char="${line:$i:1}"
        if [[ -n "${rs[$char]}" ]]; then
            result+="${rs[$char]}"
        else
            result+="$char"
        fi
    done

    echo "$result"
}

candidate() {
    f "$@"
}

set -e
run_test() {
    [[ $(candidate "abab" "a b
b a") = "baba" ]]
}

run_test
