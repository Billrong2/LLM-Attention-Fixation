#!/bin/bash
# $1 is a string
# $2 is a string
f() {
    whitespaces=$'\t\r\v \f\n'
    clean=''
    for ((i=0; i<${#1}; i++)); do
        char=${1:i:1}
        if [[ $whitespaces == *"$char"* ]]; then
            clean+=$2
        else
            clean+=$char
        fi
    done
    echo $clean
}

candidate() {
    f "$@"
}

set -e
run_test() {
    [[ $(candidate "pi wa" "chi") = "pichiwa" ]]
}

run_test
