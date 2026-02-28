#!/bin/bash
# $1 is a space-separated list
# $2 is an integer
f() {
    local numbers=($1)
    local index=$2
    local new_numbers=()

    for ((i=index; i<${#numbers[@]}; i++)); do
        new_numbers+=(${numbers[i]})
        numbers=("${numbers[@]::$index}" "${numbers[@]:$index}")
        index=$((index + 1))
    done

    echo "${new_numbers[@]}"
}

candidate() {
    f "$@"
}

set -e
run_test() {
    [[ $(candidate "-2 4 -4" "0") = "-2 4 -4" ]]
}

run_test
