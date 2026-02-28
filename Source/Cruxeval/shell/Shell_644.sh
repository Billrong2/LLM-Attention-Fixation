#!/bin/bash
# $1 is a space-separated list
# $2 is an integer
f() {
    read -a nums <<< $1
    pos=$2
    if (( pos % 2 == 1 )); then
        for i in $(seq 0 $(( ${#nums[@]} - 2 ))); do
            tmp=${nums[$i]}
            nums[$i]=${nums[-$i-2]}
            nums[-$i-2]=$tmp
        done
    fi
    echo ${nums[@]}
}

candidate() {
    f "$@"
}

set -e
run_test() {
    [[ $(candidate "6 1" "3") = "6 1" ]]
}

run_test
