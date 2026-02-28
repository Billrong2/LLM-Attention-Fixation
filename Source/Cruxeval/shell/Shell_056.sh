#!/bin/bash
# $1 is a string
f() {
    for (( i=0; i<${#1}; i++ )); do
        if [[ ! $(echo "${1:$i:1}" | grep -P '^[[:ascii:]]') ]]; then
            echo "false"
            return
        fi
    done
    echo "true"
}

candidate() {
    f "$@"
}

set -e
run_test() {
    [[ $(candidate "1z1z1") = "true" ]]
}

run_test
