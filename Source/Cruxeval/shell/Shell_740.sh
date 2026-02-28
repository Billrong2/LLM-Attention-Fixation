#!/bin/bash
# $1 is a space-separated list
# $2 is an integer
f() {
    plot=($1)
    delin=$2
    
    for ((i=0; i<${#plot[@]}; i++)); do
        if [[ ${plot[i]} -eq $delin ]]; then
            first=(${plot[@]:0:i})
            second=(${plot[@]:i+1})
            result=("${first[@]}" "${second[@]}")
            echo "${result[@]}"
            return
        fi
    done
    
    echo "$1"
}

candidate() {
    f "$@"
}

set -e
run_test() {
    [[ $(candidate "1 2 3 4" "3") = "1 2 4" ]]
}

run_test
