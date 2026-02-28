#!/bin/bash
# $1 is a string
f() {
    local digits=0
    for (( i=0; i<${#1}; i++ )); do
        char=${1:i:1}
        if [[ $char =~ [0-9] ]]; then
            ((digits++))
        fi
    done
    echo $digits
}

candidate() {
    f "$@"
}

set -e
run_test() {
    [[ $(candidate "C24Bxxx982ab") = "5" ]]
}

run_test
