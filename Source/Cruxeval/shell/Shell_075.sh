#!/bin/bash
# $1 is a space-separated list
# $2 is an integer
f() {
    array=($1)
    elem=$2
    for i in "${!array[@]}"; do
        if [[ "${array[$i]}" = "${elem}" ]]; then
            ind=$i
            break
        fi
    done
    res=$(( ind * 2 + array[-ind-1] * 3 ))
    echo $res
}

candidate() {
    f "$@"
}

set -e
run_test() {
    [[ $(candidate "-1 2 1 -8 2" "2") = "-22" ]]
}

run_test
