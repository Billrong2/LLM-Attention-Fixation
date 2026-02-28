#!/bin/bash
# $1 is a space-separated list
# $2 is a space-separated list
f() {
    result=()
    for s in $2; do
        for l in $(echo $s | tr "${1// /|}" "\n"); do
            if [ ! -z "$l" ]; then
                result+=($l)
            fi
        done
    done
    echo "${result[@]}"
}

candidate() {
    f "$@"
}

set -e
run_test() {
    [[ $(candidate "" "") = "" ]]
}

run_test
