#!/bin/bash
# $1 is a string
f() {
    echo $1 | grep -b -o "," | head -n1 | cut -d':' -f1
}

candidate() {
    f "$@"
}

set -e
run_test() {
    [[ $(candidate "There are, no, commas, in this text") = "9" ]]
}

run_test
