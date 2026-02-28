#!/bin/bash
# $1 is a space-separated list
f() {
    local digits=($1)
    for ((i=${#digits[@]}-1; i>=0; i--)); do
        reversed+=(${digits[i]})
    done

    if [ ${#reversed[@]} -lt 2 ]; then
        echo ${reversed[@]}
        return
    fi

    for ((i=0; i<${#reversed[@]}; i+=2)); do
        temp=${reversed[i]}
        reversed[i]=${reversed[i+1]}
        reversed[i+1]=$temp
    done

    echo ${reversed[@]}
}

candidate() {
    f "$@"
}

set -e
run_test() {
    [[ $(candidate "1 2") = "1 2" ]]
}

run_test
