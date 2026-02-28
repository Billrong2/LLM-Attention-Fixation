#!/bin/bash
# $1 is a string
f() {
    if echo "$1" | LC_CTYPE=C grep -q '[^ -~]'; then
        echo "non ascii"
    else
        echo "ascii"
    fi
}

candidate() {
    f "$@"
}

set -e
run_test() {
    [[ $(candidate "<<<<") = "ascii" ]]
}

run_test
