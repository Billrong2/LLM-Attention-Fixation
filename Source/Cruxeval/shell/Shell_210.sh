#!/bin/bash
# $1 is an integer
# $2 is an integer
# $3 is an integer
f() {
    x_list=($(seq $1 $2))
    j=0
    while true; do
        j=$(( (j + $3) % ${#x_list[@]} ))
        if [ $((x_list[j] % 2)) -eq 0 ]; then
            echo ${x_list[j]}
            return
        fi
    done
}

candidate() {
    f "$@"
}

set -e
run_test() {
    [[ $(candidate "46" "48" "21") = "46" ]]
}

run_test
