#!/bin/bash
# $1 is a space-separated list
# $2 is an integer
f() {
    array=($1)
    value=$2

    # Reverse array
    for ((i=${#array[@]}-1; i>=0; i--)); do
        reversed_array+=(${array[i]})
    done

    # Remove the last element
    reversed_array=("${reversed_array[@]::${#reversed_array[@]}-1}")

    odd=()
    while [ ${#reversed_array[@]} -gt 0 ]; do
        tmp=()
        tmp[${#tmp[@]}]=${reversed_array[-1]}
        tmp[${reversed_array[-1]}]=$value
        odd+=("$tmp")
        unset 'reversed_array[${#reversed_array[@]}-1]'
    done

    declare -A result
    while [ ${#odd[@]} -gt 0 ]; do
        tmp=${odd[-1]}
        for key in ${!tmp[@]}; do
            result[$key]=${tmp[$key]}
        done
        unset 'odd[${#odd[@]}-1]'
    done

    for key in "${!result[@]}"; do
        echo "$key:${result[$key]}"
    done
}

candidate() {
    f "$@"
}

set -e
run_test() {
    [[ $(candidate "23" "123") = "" ]]
}

run_test
