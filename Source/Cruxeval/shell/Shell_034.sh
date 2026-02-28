#!/bin/bash
# $1 is a space-separated list
# $2 is an integer
# $3 is an integer
f() {
    nums=($1)
    odd1=$2
    odd2=$3
    
    for i in "${!nums[@]}"; do
        if [[ ${nums[i]} -eq $odd1 ]]; then
            unset 'nums[i]'
        fi
    done
    
    for i in "${!nums[@]}"; do
        if [[ ${nums[i]} -eq $odd2 ]]; then
            unset 'nums[i]'
        fi
    done
    
    echo "${nums[@]}"
}

candidate() {
    f "$@"
}

set -e
run_test() {
    [[ $(candidate "1 2 3 7 7 6 8 4 1 2 3 5 1 3 21 1 3" "3" "1") = "2 7 7 6 8 4 2 5 21" ]]
}

run_test
