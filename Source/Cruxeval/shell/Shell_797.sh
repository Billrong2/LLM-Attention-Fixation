#!/bin/bash
# $1 is a two column CSV in key,value order
f() {
    declare -A dct
    while IFS=, read -r key value; do
        dct["$key"]=$value
    done < <(echo -e "$1")

    for key in $(printf "%s\n" "${!dct[@]}" | sort); do
        echo "$key ${dct[$key]}"
    done
}

candidate() {
    f "$@"
}

set -e
run_test() {
    [[ $(candidate "a,1
b,2
c,3") = "a 1
b 2
c 3" ]]
}

run_test
