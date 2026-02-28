#!/bin/bash
# $1 is a newline-separated, space-separated list
f() {
    matrix=($1)
    for line in "${matrix[@]}"; do
        primary=($line)
        primary=$(echo "${primary[@]}" | tr ' ' '\n' | sort -nr)
        result+=("$primary")
    done
    echo "${result[@]}"
}

candidate() {
    f "$@"
}

set -e
run_test() {
    [[ $(candidate "1 1 1 1") = "1 1 1 1" ]]
}

run_test
