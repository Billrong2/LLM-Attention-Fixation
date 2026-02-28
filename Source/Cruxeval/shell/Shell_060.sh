#!/bin/bash
# $1 is a string
f() {
    for x in $(echo $1 | grep -o .); do
        if [[ $x =~ [[:alpha:]] ]]; then
            echo ${x^}
            return
        fi
    done
    echo '-'
}

candidate() {
    f "$@"
}

set -e
run_test() {
    [[ $(candidate "raruwa") = "R" ]]
}

run_test
