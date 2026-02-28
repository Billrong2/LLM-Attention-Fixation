#!/bin/bash
# $1 is a two column CSV in key,value order
f() {
    even_keys=()
    while IFS=, read key _; do
        if [ $((key % 2)) -eq 0 ]; then
            even_keys+=($key)
        fi
    done <<< "$1"
    echo "${even_keys[@]}"
}

candidate() {
    f "$@"
}

set -e
run_test() {
    [[ $(candidate "4,a") = "4" ]]
}

run_test
