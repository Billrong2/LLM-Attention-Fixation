#!/bin/bash
# $1 is a space-separated list
# $2 is a string
f() {
    local txt=($1)
    local alpha=$2
    
    txt=($(echo "${txt[@]}" | tr ' ' '\n' | sort))
    
    index=0
    for word in "${txt[@]}"; do
        if [[ $word == $alpha ]]; then
            break
        fi
        ((index++))
    done
    
    if (( index % 2 == 0 )); then
        rev_txt=($(echo "${txt[@]}" | tr ' ' '\n' | tac))
        echo "${rev_txt[@]}"
    else
        echo "${txt[@]}"
    fi
}

candidate() {
    f "$@"
}

set -e
run_test() {
    [[ $(candidate "8 9 7 4 3 2" "9") = "2 3 4 7 8 9" ]]
}

run_test
