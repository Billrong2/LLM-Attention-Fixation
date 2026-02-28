#!/bin/bash
# $1 is a string
# $2 is a string
f() {
    count=$(echo $1 | tr -cd "$2" | wc -c)
    if [ $(($count % 2)) -eq 0 ]; then
        echo false
    else
        echo true
    fi
}

candidate() {
    f "$@"
}

set -e
run_test() {
    [[ $(candidate "abababac" "a") = "false" ]]
}

run_test
