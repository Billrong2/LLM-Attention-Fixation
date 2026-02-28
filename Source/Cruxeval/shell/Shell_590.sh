#!/bin/bash
# $1 is a string
f() {
    text=$1
    for i in {9..1}; do
        text=$(echo "${text}" | sed "s/^${i}//")
    done
    echo "${text}"
}

candidate() {
    f "$@"
}

set -e
run_test() {
    [[ $(candidate "25000   \$") = "5000   \$" ]]
}

run_test
