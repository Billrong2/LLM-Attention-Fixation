#!/bin/bash
# $1 is a string
f() {
    for i in '.' '!' '?'
    do
        if [[ $1 == *"$i" ]]; then
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
    [[ $(candidate ". C.") = "true" ]]
}

run_test
