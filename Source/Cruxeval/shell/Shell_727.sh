#!/bin/bash
# $1 is a space-separated list
# $2 is a string
f() {
    numbers=($1)
    prefix=$2
    sorted_numbers=()

    for n in "${numbers[@]}"; do
        if [[ ${#n} -gt ${#prefix} && $n == $prefix* ]]; then
            sorted_numbers+=("${n:${#prefix}}")
        else
            sorted_numbers+=("$n")
        fi
    done

    IFS=$'\n' sorted_numbers=($(sort <<<"${sorted_numbers[*]}"))
    echo "${sorted_numbers[@]}"
}

candidate() {
    f "$@"
}

set -e
run_test() {
    [[ $(candidate "ix dxh snegi wiubvu" "") = "dxh ix snegi wiubvu" ]]
}

run_test
