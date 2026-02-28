#!/bin/bash
# $1 is a two column CSV in key,value order
f() {
    local dictionary=()
    while IFS=, read -r key value; do
        dictionary+=("$key,$value")
    done < <(echo -e "$1")

    # Add the new key-value pair
    dictionary+=("1049,55")

    # Pop the last item and re-add it to simulate popitem() and re-insertion
    last_item=${dictionary[-1]}
    unset 'dictionary[-1]'
    dictionary+=("$last_item")

    # Print the dictionary in the required format
    for item in "${dictionary[@]}"; do
        echo "$item"
    done
}

candidate() {
    f "$@"
}

set -e
run_test() {
    [[ $(candidate "noeohqhk,623") = "noeohqhk,623
1049,55" ]]
}

run_test
