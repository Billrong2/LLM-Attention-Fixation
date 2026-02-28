#!/bin/bash
# $1 is a space-separated list
f() {
    selfie=($1)
    lo=${#selfie[@]}
    for ((i=lo-1; i>=0; i--)); do
        if [ ${selfie[i]} -eq ${selfie[0]} ]; then
            unset 'selfie[lo-1]'
        fi
    done
    echo "${selfie[@]}"
}

candidate() {
    f "$@"
}

set -e
run_test() {
    [[ $(candidate "4 2 5 1 3 2 6") = "4 2 5 1 3 2" ]]
}

run_test
