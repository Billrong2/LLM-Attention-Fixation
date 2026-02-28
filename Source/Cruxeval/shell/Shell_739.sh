#!/bin/bash
# $1 is a string
# $2 is a space-separated list
f() {
    local str=$1
    local patterns=($2)
    
    for pattern in "${patterns[@]}"; do
        if ! [[ $str == $pattern* ]]; then
            echo "false"
            return 1
        fi
        str=${str#${pattern}}
    done
    echo "true"
}

candidate() {
    f "$@"
}

set -e
run_test() {
    [[ $(candidate "qwbnjrxs" "jr b r qw") = "false" ]]
}

run_test
