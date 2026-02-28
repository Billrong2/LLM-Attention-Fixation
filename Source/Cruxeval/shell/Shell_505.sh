#!/bin/bash
# $1 is a string
f() {
    str="$1"
    while [ -n "$str" ]; do
        last_char="${str: -1}"
        if [[ "$last_char" =~ [a-zA-Z] ]]; then
            echo "$str"
            return
        fi
        str="${str:0: -1}"
    done
    echo "$str"
}

candidate() {
    f "$@"
}

set -e
run_test() {
    [[ $(candidate "--4/0-209") = "" ]]
}

run_test
