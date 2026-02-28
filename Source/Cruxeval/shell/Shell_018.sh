#!/bin/bash
# $1 is a space-separated list
# $2 is an integer
f() {
    local array=($1)
    local elem=$2
    local k=0
    local l=("${array[@]}")
    
    for i in "${l[@]}"; do
        if [ $i -gt $elem ]; then
            array=("${array[@]::$k}" $elem "${array[@]:$k}")
            break
        fi
        ((k++))
    done
    
    echo "${array[@]}"
}

candidate() {
    f "$@"
}

set -e
run_test() {
    [[ $(candidate "5 4 3 2 1 0" "3") = "3 5 4 3 2 1 0" ]]
}

run_test
