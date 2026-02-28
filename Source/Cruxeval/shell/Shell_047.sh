#!/bin/bash
# $1 is a string
f() {
    length=${#1}
    half=$(( $length / 2 ))
    encode=$(echo "${1:0:$half}" | iconv -t ascii)
    
    if [ "${1:$half}" = "$encode" ]; then
        echo true
    else
        echo false
    fi
}

candidate() {
    f "$@"
}

set -e
run_test() {
    [[ $(candidate "bbbbr") = "false" ]]
}

run_test
