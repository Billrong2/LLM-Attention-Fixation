#!/bin/bash
# $1 is a space-separated list
f() {
    nums=($1)
    count=${#nums[@]}
    score=(F E D C B A "")
    result=""
    for ((i=0; i<count; i++)); do
        result+=${score[${nums[i]}]}
    done
    echo $result
}

candidate() {
    f "$@"
}

set -e
run_test() {
    [[ $(candidate "4 5") = "BA" ]]
}

run_test
