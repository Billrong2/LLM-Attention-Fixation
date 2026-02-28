#!/bin/bash
# $1 is a space-separated list
f() {
    read -ra nums <<< "$1"
    n=${#nums[@]}
    nums=($(printf "%s\n" "${nums[@]}" | sort -n))

    declare -a new_nums

    if [[ $((n % 2)) -eq 0 ]]; then
        new_nums=("${nums[$n/2 - 1]}" "${nums[$n/2]}")
    else
        new_nums=("${nums[$n/2]}")
    fi

    for ((i = 0; i < n/2; i++)); do
        new_nums=("${nums[$n-i-1]}" "${new_nums[@]}")
        new_nums=("${new_nums[@]}" "${nums[$i]}")
    done

    echo "${new_nums[@]}"
}

candidate() {
    f "$@"
}

set -e
run_test() {
    [[ $(candidate "1") = "1" ]]
}

run_test
