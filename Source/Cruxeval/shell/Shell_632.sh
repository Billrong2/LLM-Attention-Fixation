#!/bin/bash
# $1 is a space-separated list
f() {
    read -a lst <<< "$1"
    n=${#lst[@]}
    for (( i=n-1; i>0; i-- ))
    do
        for (( j=0; j<i; j++ ))
        do
            if [ ${lst[j]} -gt ${lst[j+1]} ]
            then
                tmp=${lst[j]}
                lst[j]=${lst[j+1]}
                lst[j+1]=$tmp
            fi
        done
    done
    echo "${lst[@]}"
}

candidate() {
    f "$@"
}

set -e
run_test() {
    [[ $(candidate "63 0 1 5 9 87 0 7 25 4") = "0 0 1 4 5 7 9 25 63 87" ]]
}

run_test
