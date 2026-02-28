#!/bin/bash
# $1 is an integer
# $2 is an integer
f() {
    integer=$1
    n=$2
    i=1
    text=$integer
    while (( $((i+len)) < n )); do
        i=$((i+${#text}))
    done
    printf "%0*d" $((i+len)) $text
}

candidate() {
    f "$@"
}

set -e
run_test() {
    [[ $(candidate "8999" "2") = "08999" ]]
}

run_test
