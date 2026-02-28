#!/bin/bash
# $1 is a string
f() {
    a=($1)
    for word in "${a[@]}"; do
        if ! [[ $word =~ ^[0-9]+$ ]]; then
            echo '-'
            return
        fi
    done
    echo $1
}

candidate() {
    f "$@"
}

set -e
run_test() {
    [[ $(candidate "d khqw whi fwi bbn 41") = "-" ]]
}

run_test
