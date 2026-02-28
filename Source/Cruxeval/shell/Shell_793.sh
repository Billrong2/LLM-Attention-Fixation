#!/bin/bash
# $1 is a space-separated list
# $2 is an integer
# $3 is an integer
f() {
    lst=($1)
    start=$2
    end=$3
    count=0
    for (( i=start; i<end; i++ )); do
        for (( j=i; j<end; j++ )); do
            if [[ ${lst[i]} -ne ${lst[j]} ]]; then
                count=$((count+1))
            fi
        done
    done
    echo $count
}

candidate() {
    f "$@"
}

set -e
run_test() {
    [[ $(candidate "1 2 4 3 2 1" "0" "3") = "3" ]]
}

run_test
