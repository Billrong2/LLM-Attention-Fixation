#!/bin/bash
# $1 is a string
f() {
    numbers=$1
    for ((i=0; i<${#numbers}; i++)); do
        if [[ $(grep -o '3' <<< "$numbers" | wc -l) -gt 1 ]]; then
            echo $i
            return
        fi
    done
    echo -1
}

candidate() {
    f "$@"
}

set -e
run_test() {
    [[ $(candidate "23157") = "-1" ]]
}

run_test
