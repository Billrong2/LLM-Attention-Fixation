#!/bin/bash
# $1 is a string
f() {
    b=true
    for x in $(echo $1 | grep -o .); do
        if [[ $x =~ [0-9] ]]; then
            b=true
        else
            b=false
            break
        fi
    done
    echo $b
}

candidate() {
    f "$@"
}

set -e
run_test() {
    [[ $(candidate "-1-3") = "false" ]]
}

run_test
