#!/bin/bash
# $1 is a space-separated list
f() {
    arr=($1)
    len=${#arr[@]}
    limit=$((len / 2))
    for ((k = 1; k <= limit; k++)); do
        i=$(($k - 1))
        j=$(($len - $k))
        while [ $i -lt $j ]; do
            temp=${arr[$i]}
            arr[$i]=${arr[$j]}
            arr[$j]=$temp
            i=$(($i + 1))
            j=$(($j - 1))
        done
    done
    echo "${arr[@]}"
}

candidate() {
    f "$@"
}

set -e
run_test() {
    [[ $(candidate "16 14 12 7 9 11") = "11 14 7 12 9 16" ]]
}

run_test
