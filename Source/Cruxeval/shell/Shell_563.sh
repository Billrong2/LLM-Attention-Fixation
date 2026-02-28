#!/bin/bash
# $1 is a string
# $2 is a string
f() {
    nums=()
    for (( i=0; i<${#2}; i++ )); do
        nums+=( $(echo $1 | grep -o "${2:i:1}" | wc -l) )
    done

    sum=0
    for num in "${nums[@]}"; do
        sum=$((sum + num))
    done

    echo $sum
}

candidate() {
    f "$@"
}

set -e
run_test() {
    [[ $(candidate "jivespdcxc" "sx") = "2" ]]
}

run_test
