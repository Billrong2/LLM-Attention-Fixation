#!/bin/bash
# $1 is a string
f() {
    count=$(echo $1 | grep -o . | grep -c ${1:0:1})
    text=$1
    for i in $(seq $count); do
        text=$(echo $text | sed 's/^.\(.*\)/\1/')
    done
    echo $text
}

candidate() {
    f "$@"
}

set -e
run_test() {
    [[ $(candidate ";,,,?") = ",,,?" ]]
}

run_test
