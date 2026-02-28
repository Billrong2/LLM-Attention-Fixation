#!/bin/bash
# $1 is a space-separated list
# $2 is a space-separated list
f() {
    array=($1)
    values=($2)
    reversed_array=()
    
    for ((i=${#array[@]}-1; i>=0; i--)); do
        reversed_array+=(${array[i]})
    done
    
    for value in "${values[@]}"; do
        index=$((${#reversed_array[@]} / 2))
        reversed_array=(${reversed_array[@]:0:index} $value ${reversed_array[@]:index})
    done
    
    result=()
    for ((i=${#reversed_array[@]}-1; i>=0; i--)); do
        result+=(${reversed_array[i]})
    done
    
    echo "${result[@]}"
}

candidate() {
    f "$@"
}

set -e
run_test() {
    [[ $(candidate "58" "21 92") = "58 92 21" ]]
}

run_test
