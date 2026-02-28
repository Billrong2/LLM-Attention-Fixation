#!/bin/bash
# $1 is a space-separated list
# $2 is an integer
# $3 is a string
f() {
    numbers=($1)
    num=$2
    val=$3
    
    while [ ${#numbers[@]} -lt $num ]; do
        numbers=("${numbers[@]::${#numbers[@]}/2}" "$val" "${numbers[@]:${#numbers[@]}/2}")
    done
    
    for ((i=0; i<${#numbers[@]}/($num-1)-4; i++)); do
        numbers=("${numbers[@]::${#numbers[@]}/2}" "$val" "${numbers[@]:${#numbers[@]}/2}")
    done
    
    echo "${numbers[*]}"
}

candidate() {
    f "$@"
}

set -e
run_test() {
    [[ $(candidate "" "0" "1") = "" ]]
}

run_test
