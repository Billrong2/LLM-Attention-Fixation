#!/bin/bash
# $1 is a string
# $2 is an integer
f() {
    if [ $2 -eq 0 ]; then
        echo $1
    else
        echo $1 | tr 'a-zA-Z' 'n-za-mN-ZA-M'
    fi
}

candidate() {
    f "$@"
}

set -e
run_test() {
    [[ $(candidate "UppEr" "0") = "UppEr" ]]
}

run_test
