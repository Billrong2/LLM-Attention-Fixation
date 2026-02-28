#!/bin/bash
# $1 is a two column CSV in key,value order
f() {
    declare -A dic
    while IFS=, read -r key value; do
        dic["$key"]=$value
    done < <(echo -e "$1")

    for key in "${!dic[@]}"; do
        echo "$key ${dic[$key]}"
    done | sort
}

candidate() {
    f "$@"
}

set -e
run_test() {
    [[ $(candidate "b,1
a,2") = "a 2
b 1" ]]
}

run_test
