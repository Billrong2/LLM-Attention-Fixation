#!/bin/bash
# $1 is a string
f() {
    i=0
    while [ $i -lt ${#1} ] && [ "${1:$i:1}" == " " ]; do
        i=$((i+1))
    done
    if [ $i -eq ${#1} ]; then
        echo "space"
    else
        echo "no"
    fi
}

candidate() {
    f "$@"
}

set -e
run_test() {
    [[ $(candidate "     ") = "space" ]]
}

run_test
