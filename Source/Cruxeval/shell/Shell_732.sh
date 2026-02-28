#!/bin/bash
# $1 is a two column CSV in key,value order
f() {
    local result=""
    while IFS=, read -r key value; do
        half_value=$((value / 2))
        result+="$key,$half_value"$'\n'
    done < <(echo -e "$1")
    echo -n "$result"
}

candidate() {
    f "$@"
}

set -e
run_test() {
    [[ $(candidate "u,20
v,5
b,7
w,3
x,3") = "u,10
v,2
b,3
w,1
x,1" ]]
}

run_test
