#!/bin/bash
# $1 is a space-separated list
# $2 is an integer
f() {
    array=($1)
    for i in "${!array[@]}"; do
        if [[ ${array[$i]} -eq $2 ]]; then
            echo $i
            return
        fi
    done
    echo -1
}

candidate() {
    f "$@"
}

set -e
run_test() {
    [[ $(candidate "6 2 7 1" "6") = "0" ]]
}

run_test
