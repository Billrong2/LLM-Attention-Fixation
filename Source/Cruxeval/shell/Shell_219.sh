#!/bin/bash
# $1 is a string
# $2 is a string
f() {
    for ((k=0; k<${#2}+${#1}; k++)); do
        s1=$s1${s1:0:1}
        if [[ $s1 == *$2* ]]; then
            echo true
            return
        fi
    done
    echo false
}

candidate() {
    f "$@"
}

set -e
run_test() {
    [[ $(candidate "Hello" ")") = "false" ]]
}

run_test
