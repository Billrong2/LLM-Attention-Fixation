#!/bin/bash
# $1 is a string
f() {
    txt=$1
    declare -A coincidences
    for (( i=0; i<${#txt}; i++ )); do
        c=${txt:i:1}
        if [[ -n ${coincidences[$c]} ]]; then
            (( coincidences[$c]++ ))
        else
            coincidences[$c]=1
        fi
    done
    
    total=0
    for val in "${coincidences[@]}"; do
        (( total += val ))
    done
    
    echo $total
}

candidate() {
    f "$@"
}

set -e
run_test() {
    [[ $(candidate "11 1 1") = "6" ]]
}

run_test
