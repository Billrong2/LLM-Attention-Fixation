#!/bin/bash
# $1 is a string
f() {
    for ((i=0; i<${#1}; i++)); do
        char=${1:i:1}
        if ! [[ $char =~ [[:space:]] ]]; then
            echo "false"
            return
        fi
    done
    echo "true"
}

candidate() {
    f "$@"
}

set -e
run_test() {
    [[ $(candidate "     i") = "false" ]]
}

run_test
