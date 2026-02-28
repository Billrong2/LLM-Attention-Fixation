#!/bin/bash
# $1 is a string
f() {
    if echo "$1" | grep -q '^[[:space:]]*$'; then
        echo "false"
    else
        echo "true"
    fi
}

candidate() {
    f "$@"
}

set -e
run_test() {
    [[ $(candidate " 	  　") = "true" ]]
}

run_test
