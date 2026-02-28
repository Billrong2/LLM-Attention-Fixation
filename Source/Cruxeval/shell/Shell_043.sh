#!/bin/bash
# $1 is a string
f() {
    local n=$1
    for i in $(echo $1 | grep -o .); do
        if ! [[ $i =~ ^[0-9]+$ ]]; then
            n=-1
            break
        fi
    done
    echo $n
}

candidate() {
    f "$@"
}

set -e
run_test() {
    [[ $(candidate "6 ** 2") = "-1" ]]
}

run_test
