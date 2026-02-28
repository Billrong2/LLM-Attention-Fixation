#!/bin/bash
# $1 is a string
# $2 is a string
f() {
    total=0
    for ((i=0;i<${#1};i++)); do
        if [ "${1:i:1}" = "$2" ] || [ "${1:i:1}" = "$(echo $2 | tr '[:upper:]' '[:lower:]')" ]; then
            ((total++))
        fi
    done
    echo $total
}

candidate() {
    f "$@"
}

set -e
run_test() {
    [[ $(candidate "234rtccde" "e") = "1" ]]
}

run_test
