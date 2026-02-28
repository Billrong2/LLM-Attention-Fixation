#!/bin/bash
# $1 is a string
f() {
    lines=$(echo -e "$1" | wc -l)
    echo $lines
}

candidate() {
    f "$@"
}

set -e
run_test() {
    [[ $(candidate "145\n\n12fjkjg") = "3" ]]
}

run_test
