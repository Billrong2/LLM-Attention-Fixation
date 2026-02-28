#!/bin/bash
# $1 is a string
f() {
    local created=()
    local line
    local flush=0
    IFS=$'\n'
    for line in $1; do
        if [ -z "$line" ]; then
            break
        fi
        created+=($(echo "$line" | rev | cut -c $((flush+1))))
    done
    
    for ((i=${#created[@]}-1; i>=0; i--)); do
        echo "${created[i]}"
    done
}

candidate() {
    f "$@"
}

set -e
run_test() {
    [[ $(candidate "A(hiccup)A") = "A" ]]
}

run_test
