#!/bin/bash
# $1 is a space-separated list
# $2 is a space-separated list
f() {
    read -ra arr_a <<< "$1"
    read -ra arr_b <<< "$2"
    
    for i in "${!arr_a[@]}"; do
        arr_a[$i]=$((${arr_a[$i]}))
    done
    
    for i in "${!arr_b[@]}"; do
        arr_b[$i]=$((${arr_b[$i]}))
    done
    
    IFS=$'\n' sorted_a=($(sort <<<"${arr_a[*]}"))
    IFS=$'\n' sorted_b=($(sort -r <<<"${arr_b[*]}"))
    
    result=("${sorted_a[@]}" "${sorted_b[@]}")
    
    echo "${result[*]}"
}

candidate() {
    f "$@"
}

set -e
run_test() {
    [[ $(candidate "666" "") = "666" ]]
}

run_test
