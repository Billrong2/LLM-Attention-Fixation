#!/bin/bash
# $1 is a two column CSV in key,value order
f() {
    declare -A dict
    while IFS=, read -r key value; do
        dict["$key"]=$value
    done < <(echo -e "$1")

    # Get the keys sorted in reverse order
    keys=($(for k in "${!dict[@]}"; do echo $k; done | sort -nr))

    # Get the top two keys
    key1=${keys[0]}
    key2=${keys[1]}

    # Get the values for the top two keys
    val1=${dict[$key1]}
    val2=${dict[$key2]}

    # Output the result in the required format
    echo "$key1,$val1"
    echo "$key2,$val2"
}

candidate() {
    f "$@"
}

set -e
run_test() {
    [[ $(candidate "2,3
17,3
16,6
18,6
87,7") = "87,7
18,6" ]]
}

run_test
