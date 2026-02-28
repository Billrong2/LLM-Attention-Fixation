#!/bin/bash
# $1 is a space-separated list
f() {
    read -a nums <<< $1
    count=0
    for i in $(seq 1 ${#nums[@]}); do
        if (( count % 2 == 0 )); then
            nums=("${nums[@]:0:$((${#nums[@]}-1))}")
        else
            nums=("${nums[@]:1}")
        fi
        ((count++))
    done
    echo "${nums[@]}"
}

candidate() {
    f "$@"
}

set -e
run_test() {
    [[ $(candidate "3 2 0 0 2 3") = "" ]]
}

run_test
