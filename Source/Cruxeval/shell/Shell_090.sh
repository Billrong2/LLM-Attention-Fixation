#!/bin/bash
# $1 is a newline-separated, space-separated list
f() {
    while read -r line; do
        echo "$line"
    done <<< "$1"
}

candidate() {
    f "$@"
}

set -e
run_test() {
    [[ $(candidate "1 2 3

1 2 3") = "1 2 3

1 2 3" ]]
}

run_test
