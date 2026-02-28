#!/bin/bash
# $1 is a space-separated list
f() {
    nums=($1)
    declare -A count_map
    output=()

    # Count occurrences
    for n in "${nums[@]}"; do
        ((count_map[$n]++))
    done

    # Create output list
    for n in "${nums[@]}"; do
        output+=("${count_map[$n]} $n")
    done

    # Sort output list in reverse order
    printf "%s\n" "${output[@]}" | sort -r
}

candidate() {
    f "$@"
}

set -e
run_test() {
    [[ $(candidate "1 1 3 1 3 1") = "4 1
4 1
4 1
4 1
2 3
2 3" ]]
}

run_test
