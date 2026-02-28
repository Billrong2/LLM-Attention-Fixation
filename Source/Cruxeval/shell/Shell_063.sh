#!/bin/bash
# $1 is a string
# $2 is a string
f() {
    while [[ $1 == $2* ]]; do
        text=${1#$2}
        text=${text:-$1}
        set -- "$text" "$2"
    done
    echo $1
}

candidate() {
    f "$@"
}

set -e
run_test() {
    [[ $(candidate "ndbtdabdahesyehu" "n") = "dbtdabdahesyehu" ]]
}

run_test
