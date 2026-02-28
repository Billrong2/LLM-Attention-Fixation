#!/bin/bash
# $1 is a string
f() {
    result=""
    for (( i=0; i<${#1}; i++ )); do
        c=${1:i:1}
        if [[ $c =~ [0-9] ]]; then
            continue
        fi
        if [[ $c =~ [a-z] ]]; then
            result+=$(echo $c | tr '[:lower:]' '[:upper:]')
        elif [[ $c =~ [A-Z] ]]; then
            result+=$(echo $c | tr '[:upper:]' '[:lower:]')
        fi
    done
    echo $result
}

candidate() {
    f "$@"
}

set -e
run_test() {
    [[ $(candidate "5ll6") = "LL" ]]
}

run_test
