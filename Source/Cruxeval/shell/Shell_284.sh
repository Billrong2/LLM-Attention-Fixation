#!/bin/bash
# $1 is a string
# $2 is a string
f() {
    prefix=$2
    idx=0
    for ((i=0; i<${#prefix}; i++)); do
        if [ "${1:$idx:1}" != "${prefix:$i:1}" ]; then
            echo "None"
            return
        fi
        ((idx++))
    done
    echo "${1:$idx}"
}

candidate() {
    f "$@"
}

set -e
run_test() {
    [[ $(candidate "bestest" "bestest") = "" ]]
}

run_test
