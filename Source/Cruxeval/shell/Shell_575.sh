#!/bin/bash
# $1 is a space-separated list
# $2 is an integer
f() {
    nums=($1)
    val=$2
    new_list=()
    
    for i in "${nums[@]}"; do
        for (( j=0; j<$val; j++ )); do
            new_list+=($i)
        done
    done

    sum=0
    for n in "${new_list[@]}"; do
        sum=$(( $sum + $n ))
    done

    echo $sum
}

candidate() {
    f "$@"
}

set -e
run_test() {
    [[ $(candidate "10 4" "3") = "42" ]]
}

run_test
