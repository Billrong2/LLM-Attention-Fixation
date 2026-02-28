#!/bin/bash
# $1 is a space-separated list
# $2 is a space-separated list
f() {
    first=($1)
    second=($2)
    
    if [ ${#first[@]} -lt 10 ] || [ ${#second[@]} -lt 10 ]; then
        echo 'no'
    else
        for ((i=0; i<5; i++)); do
            if [ ${first[i]} -ne ${second[i]} ]; then
                echo 'no'
                exit
            fi
        done
        first+=("${second[@]}")
        echo "${first[@]}"
    fi
}

candidate() {
    f "$@"
}

set -e
run_test() {
    [[ $(candidate "1 2 1" "1 1 2") = "no" ]]
}

run_test
