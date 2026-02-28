#!/bin/bash
# $1 is a space-separated list
# $2 is an integer
f() {
    array=($1)
    num=$2
    reverse=false

    if [ $num -lt 0 ]; then
        reverse=true
        num=$((num * -1))
    fi

    array=($(echo ${array[@]} | tr ' ' '\n' | tac | tr '\n' ' ') )
    array=($(for i in $(seq 1 $num); do echo ${array[@]}; done))

    l=${#array[@]}

    if [ $reverse = true ]; then
        array=($(echo ${array[@]} | tr ' ' '\n' | tac | tr '\n' ' '))
    fi

    echo ${array[@]}
}

candidate() {
    f "$@"
}

set -e
run_test() {
    [[ $(candidate "1 2" "1") = "2 1" ]]
}

run_test
