#!/bin/bash
# $1 is a space-separated list
# $2 is an integer
# $3 is an integer
f() {
    array=($1)
    x=$2
    i=$3
    if [ $i -lt -${#array[@]} ] || [ $i -gt $((${#array[@]} - 1)) ]; then
        echo 'no'
    else
        temp=${array[i]}
        array[i]=$x
        echo ${array[@]}
    fi
}

candidate() {
    f "$@"
}

set -e
run_test() {
    [[ $(candidate "1 2 3 4 5 6 7 8 9 10" "11" "4") = "1 2 3 4 11 6 7 8 9 10" ]]
}

run_test
