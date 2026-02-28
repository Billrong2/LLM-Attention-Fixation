#!/bin/bash
# $1 is a string
# $2 is a string
f() {
    local s=$1
    local p=$2
    
    arr=($(echo "$s" | awk -v pat="$p" 'BEGIN {FS=pat} {print $1, pat, $2}'))
    part_one=${#arr[0]}
    part_two=${#arr[1]}
    part_three=${#arr[2]}
    
    if (( part_one >= 2 && part_two <= 2 && part_three >= 2 )); then
        echo "${arr[0]::-1}${arr[1]}${arr[2]::-1}#"
    else
        echo "${arr[0]}${arr[1]}${arr[2]}"
    fi
}

candidate() {
    f "$@"
}

set -e
run_test() {
    [[ $(candidate "qqqqq" "qqq") = "qqqqq" ]]
}

run_test
