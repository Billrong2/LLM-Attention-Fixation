#!/bin/bash
# $1 is a space-separated list
f() {
    nums=($1)
    count=${#nums[@]}
    for ((i=1; i<$count; i++))
    do
        for ((j=0; j<$count-i; j++))
        do
            if ((nums[j] > nums[j+1]))
            then
                temp=${nums[j]}
                nums[j]=${nums[j+1]}
                nums[j+1]=$temp
            fi
        done
    done
    echo "${nums[@]}"
}

candidate() {
    f "$@"
}

set -e
run_test() {
    [[ $(candidate "-6 -5 -7 -8 2") = "-8 -7 -6 -5 2" ]]
}

run_test
