#!/bin/bash
# $1 is a string
f() {
    letters=""
    for ((i=0; i<${#1}; i++)); do
        char="${1:i:1}"
        if [[ $char =~ [a-zA-Z0-9] ]]; then
            letters+=$char
        fi
    done
    echo $letters
}

candidate() {
    f "$@"
}

set -e
run_test() {
    [[ $(candidate "we@32r71g72ug94=(823658*\!@324") = "we32r71g72ug94823658324" ]]
}

run_test
