#!/bin/bash
# $1 is a string
# $2 is a string
f() {
    if [[ $1 == *$2* ]]; then
        IFS="$2" read -ra text <<< "$1"
        if [ ${#text[@]} -gt 1 ]; then
            echo true
        else
            echo false
        fi
    else
        echo false
    fi
}

candidate() {
    f "$@"
}

set -e
run_test() {
    [[ $(candidate "only one line" " ") = "true" ]]
}

run_test
