#!/bin/bash
# $1 is a space-separated list
# $2 is a space-separated list
f() {
    read -ra names <<< "$1"
    read -ra winners <<< "$2"
    for name in "${names[@]}"; do
        if [[ " ${winners[@]} " =~ " $name " ]]; then
            ls+=($(expr ${!names[@]} - 1))
        fi
    done
    IFS=$'\n' sorted=($(sort -nr <<<"${ls[*]}"))
    echo "${sorted[*]}"
}

candidate() {
    f "$@"
}

set -e
run_test() {
    [[ $(candidate "e f j x r k" "a v 2 im nb vj z") = "" ]]
}

run_test
