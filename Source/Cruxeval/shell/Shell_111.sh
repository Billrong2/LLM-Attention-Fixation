#!/bin/bash
# $1 is a two column CSV in key,value order
f() {
    local highest=0
    local lowest=100
    while IFS=, read -r key value; do
        if [ "$value" -gt "$highest" ]; then
            highest=$value
        fi
        if [ "$value" -lt "$lowest" ]; then
            lowest=$value
        fi
    done < <(echo -e "$1")
    echo "$highest $lowest"
}

candidate() {
    f "$@"
}

set -e
run_test() {
    [[ $(candidate "x,67
v,89
,4
alij,11
kgfsd,72
yafby,83") = "89 4" ]]
}

run_test
