#!/bin/bash
# $1 is a string
# $2 is a string
# $3 is an integer
f() {
    local result
    local m=$2
    local a=$1
    for ((i=0; i<$3; i++)); do
        if [ -n "$m" ]; then
            a=$(echo $a | sed "s/$m//")
            m=""
            result=$m
        fi
    done
    echo $result$(echo $a | tr -s "$2")
}

candidate() {
    f "$@"
}

set -e
run_test() {
    [[ $(candidate "unrndqafi" "c" "2") = "unrndqafi" ]]
}

run_test
