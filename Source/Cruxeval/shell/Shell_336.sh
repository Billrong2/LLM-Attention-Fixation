#!/bin/bash
# $1 is a string
# $2 is a string
f() {
    s="$1$2"
    echo "${s%$2}"
}

candidate() {
    f "$@"
}

set -e
run_test() {
    [[ $(candidate "234dsfssdfs333324314" "s") = "234dsfssdfs333324314" ]]
}

run_test
