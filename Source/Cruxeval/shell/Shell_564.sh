#!/bin/bash
# $1 is a newline-separated, space-separated list
f() {
    local input=("$@")
    local lists=()
    local list=()
    local i=0

    # Read the input into lists
    while IFS= read -r line; do
        if [ -z "$line" ]; then
            lists+=("$(echo "${list[@]}")")
            list=()
            ((i++))
        else
            list+=($line)
        fi
    done <<< "$1"
    lists+=("$(echo "${list[@]}")")

    # Clear the second list
    lists[1]=""

    # Append the second list to the third list
    lists[2]="${lists[2]} ${lists[1]}"

    # Return the first list
    echo "${lists[0]}"
}

candidate() {
    f "$@"
}

set -e
run_test() {
    [[ $(candidate "395 666 7 4

4223 111") = "395 666 7 4" ]]
}

run_test
