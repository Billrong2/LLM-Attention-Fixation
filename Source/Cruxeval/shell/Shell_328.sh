#!/bin/bash
# $1 is a space-separated list
# $2 is an integer
f() {
    local array=($1)
    local L=$2
    if [ $L -le 0 ]; then
        echo "${array[@]}"
    elif [ ${#array[@]} -lt $L ]; then
        array+=($(f "${array[*]}" $(($L - ${#array[@]}))))
        echo "${array[@]}"
    else
        echo "${array[@]}"
    fi
}

candidate() {
    f "$@"
}

set -e
run_test() {
    [[ $(candidate "1 2 3" "4") = "1 2 3 1 2 3" ]]
}

run_test
