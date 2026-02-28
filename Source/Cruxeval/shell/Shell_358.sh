#!/bin/bash
# $1 is a string
# $2 is a string
f() {
    text=$1
    value=$2
    indexes=()
    for ((i=0; i<${#text}; i++)); do
        if [ "${text:i:1}" = "$value" ] && { ((i == 0)) || [ "${text:i-1:1}" != "$value" ]; }; then
            indexes+=($i)
        fi
    done

    if (( ${#indexes[@]} % 2 == 1 )); then
        echo $text
    else
        start=$((indexes[0] + 1))
        end=$((indexes[${#indexes[@]} - 1]))
        echo ${text:start:end-start}
    fi
}

candidate() {
    f "$@"
}

set -e
run_test() {
    [[ $(candidate "btrburger" "b") = "tr" ]]
}

run_test
