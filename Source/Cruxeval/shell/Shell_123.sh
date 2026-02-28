#!/bin/bash
# $1 is a space-separated list
# $2 is an integer
f() {
    array=($1)
    elem=$2
    for ((idx=1; idx<${#array[@]}; idx++)); do
        if [[ ${array[idx]} -gt $elem && ${array[idx - 1]} -lt $elem ]]; then
            array=("${array[@]:0:idx}" $elem "${array[@]:idx}")
        fi
    done
    echo "${array[@]}"
}

candidate() {
    f "$@"
}

set -e
run_test() {
    [[ $(candidate "1 2 3 5 8" "6") = "1 2 3 5 6 8" ]]
}

run_test
