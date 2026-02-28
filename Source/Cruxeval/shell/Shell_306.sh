#!/bin/bash
# $1 is a newline-separated, space-separated list
f() {
    nums=($1)
    digits=()
    for num in "${nums[@]}"; do
        if [[ $num =~ ^[0-9]+$ ]] || [[ $num =~ ^-?[0-9]+$ ]]; then
            digits+=($num)
        fi
    done
    echo "${digits[@]}"
}

candidate() {
    f "$@"
}

set -e
run_test() {
    [[ $(candidate "0 6 1 2 0") = "0 6 1 2 0" ]]
}

run_test
