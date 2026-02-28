#!/bin/bash
# $1 is a string
f() {
    if [ -z "$1" ] || [[ ! "${1:0:1}" =~ [0-9] ]]; then
        echo 'INVALID'
        return
    fi

    cur=0
    for ((i=0; i < ${#1}; i++)); do
        cur=$(( $cur * 10 + ${1:i:1} ))
    done
    echo $cur
}

candidate() {
    f "$@"
}

set -e
run_test() {
    [[ $(candidate "3") = "3" ]]
}

run_test
