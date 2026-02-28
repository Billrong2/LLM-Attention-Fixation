#!/bin/bash
# $1 is a space-separated list
# $2 is an integer
# $3 is an integer
f() {
    values=($1)
    item1=$2
    item2=$3
    
    if [ "${values[-1]}" -eq $item2 ]; then
        if [[ ! " ${values[@]:1} " =~ " ${values[0]} " ]]; then
            values+=(${values[0]})
        fi
    elif [ "${values[-1]}" -eq $item1 ]; then
        if [ "${values[0]}" -eq $item2 ]; then
            values+=(${values[0]})
        fi
    fi
    echo "${values[@]}"
}

candidate() {
    f "$@"
}

set -e
run_test() {
    [[ $(candidate "1 1" "2" "3") = "1 1" ]]
}

run_test
