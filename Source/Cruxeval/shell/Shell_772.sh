#!/bin/bash
# $1 is a string
f() {
    result=''
    for (( i=0; i<${#1}; i++ )); do
        char=${1:i:1}
        if [[ ! $char =~ [a-z] ]]; then
            result+=${char}
        fi
    done
    echo ${result}
}

candidate() {
    f "$@"
}

set -e
run_test() {
    [[ $(candidate "serjgpoDFdbcA.") = "DFA." ]]
}

run_test
