#!/bin/bash
# $1 is an integer
f() {
    initial=(1)
    total=(${initial[@]})
    for ((i=0; i<$1; i++)); do
        new_total=(1)
        for ((j=0; j<${#total[@]}-1; j++)); do
            new_total+=($(( ${total[j]} + ${total[j+1]} )))
        done
        total=(${new_total[@]})
        initial+=(${total[-1]})
    done

    sum=0
    for elem in ${initial[@]}; do
        sum=$(( $sum + $elem ))
    done
    echo $sum
}

candidate() {
    f "$@"
}

set -e
run_test() {
    [[ $(candidate "3") = "4" ]]
}

run_test
