#!/bin/bash
# $1 is a string
# $2 is a string
f() {
    if [[ $1 == $2* ]]; then
        n=${#2}
        text=$(echo $1 | cut -d'.' -f2- | cut -d'.' -f-$((n-1)))
    fi
    echo $text
}

candidate() {
    f "$@"
}

set -e
run_test() {
    [[ $(candidate "omeunhwpvr.dq" "omeunh") = "dq" ]]
}

run_test
