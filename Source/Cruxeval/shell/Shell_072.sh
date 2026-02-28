#!/bin/bash
# $1 is a string
f() {
    for ((i=0; i<${#1}; i++)); do
        if ! [[ ${1:$i:1} =~ [0-9] ]]; then
            echo "false"
            return
        fi
    done
    if [ -n "$1" ]; then
        echo "true"
    else
        echo "false"
    fi
}

candidate() {
    f "$@"
}

set -e
run_test() {
    [[ $(candidate "99") = "true" ]]
}

run_test
