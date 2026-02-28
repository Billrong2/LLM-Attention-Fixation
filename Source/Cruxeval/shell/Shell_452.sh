#!/bin/bash
# $1 is a string
f() {
    counter=0
    for ((i=0; i<${#1}; i++)); do
        char=${1:i:1}
        if [[ $char =~ [a-zA-Z] ]]; then
            ((counter++))
        fi
    done
    echo $counter
}

candidate() {
    f "$@"
}

set -e
run_test() {
    [[ $(candidate "l000*") = "1" ]]
}

run_test
