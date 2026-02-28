#!/bin/bash
# $1 is a two column CSV in key,value order
f() {
    local input="$1"
    local -a lines
    local line

    # Read the input into an array
    while IFS= read -r line; do
        lines+=("$line")
    done < <(echo -e "$input")

    # Remove the last item
    unset 'lines[-1]'

    # Print the remaining items in CSV format
    for line in "${lines[@]}"; do
        echo "$line"
    done
}

candidate() {
    f "$@"
}

set -e
run_test() {
    [[ $(candidate "l,1
t,2
x:,3") = "l,1
t,2" ]]
}

run_test
