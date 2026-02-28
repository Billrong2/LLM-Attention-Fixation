#!/bin/bash
# $1 is a space-separated list
f() {
    read -a nums <<< "$1"
    asc=("${nums[@]}")
    desc=()
    for ((i=${#asc[@]}-1; i>=0; i--)); do
        desc+=(${asc[$i]})
    done
    len=${#asc[@]}
    middle=$(( len / 2 ))
    desc=("${asc[@]:$middle}")
    echo "${desc[@]}" "${asc[@]}" "${desc[@]}"
}

candidate() {
    f "$@"
}

set -e
run_test() {
    [[ $(candidate "") = "" ]]
}

run_test
