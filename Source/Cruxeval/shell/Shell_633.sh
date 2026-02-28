#!/bin/bash
# $1 is a space-separated list
# $2 is an integer
f() {
    read -a array <<< $1
    reversed_array=($(echo "${array[@]}" | tac -s ' '))
    found=-1
    for index in "${!reversed_array[@]}"; do
        if [[ ${reversed_array[index]} -eq $2 ]]; then
            found=$index
            break
        fi
    done
    echo $found
}

candidate() {
    f "$@"
}

set -e
run_test() {
    [[ $(candidate "5 -3 3 2" "2") = "0" ]]
}

run_test
