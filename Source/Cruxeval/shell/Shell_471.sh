#!/bin/bash
# $1 is a string
# $2 is a string
f() {
    text=$2
    val=$1
    indices=()
    for (( index=0; index<${#text}; index++ )); do
        if [ "${text:index:1}" = "$val" ]; then
            indices+=($index)
        fi
    done

    if [ ${#indices[@]} -eq 0 ]; then
        echo -1
    else
        echo ${indices[0]}
    fi
}

candidate() {
    f "$@"
}

set -e
run_test() {
    [[ $(candidate "o" "fnmart") = "-1" ]]
}

run_test
