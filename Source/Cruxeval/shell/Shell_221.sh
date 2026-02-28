#!/bin/bash
# $1 is a string
# $2 is a string
f() {
    first=$(echo "$1" | cut -d "$2" -f1)
    second=$(echo "$1" | cut -d "$2" -f2)
    echo "$second$2$first"
}

candidate() {
    f "$@"
}

set -e
run_test() {
    [[ $(candidate "bpxa24fc5." ".") = ".bpxa24fc5" ]]
}

run_test
