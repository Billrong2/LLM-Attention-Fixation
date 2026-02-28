#!/bin/bash
# $1 is a space-separated list
f() {
    width=$(echo $1 | cut -d' ' -f1)
    values=($(echo $1 | cut -d' ' -f2-))
    for val in "${values[@]}"; do
        formatted_val=$(printf "%0${width}d" $val)
        result+=("$formatted_val")
    done
    echo "${result[@]}"
}

candidate() {
    f "$@"
}

set -e
run_test() {
    [[ $(candidate "1 2 2 44 0 7 20257") = "2 2 44 0 7 20257" ]]
}

run_test
