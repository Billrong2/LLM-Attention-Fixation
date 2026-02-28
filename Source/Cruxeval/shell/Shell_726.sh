#!/bin/bash
# $1 is a string
f() {
    ws=0
    for (( i=0; i<${#1}; i++ )); do
        if [[ "${1:i:1}" == " " ]]; then
            (( ws++ ))
        fi
    done
    echo "$ws ${#1}"
}

candidate() {
    f "$@"
}

set -e
run_test() {
    [[ $(candidate "jcle oq wsnibktxpiozyxmopqkfnrfjds") = "2 34" ]]
}

run_test
