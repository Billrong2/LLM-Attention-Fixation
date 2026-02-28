#!/bin/bash
# $1 is a string
# $2 is an integer
f() {
    text=$1
    size=$2
    counter=${#text}
    for ((i=0; i<size-size%2; i++)); do
        text=" ${text} "
        counter=$((counter+2))
        if ((counter >= size)); then
            echo "${text}"
            return
        fi
    done
}

candidate() {
    f "$@"
}

set -e
run_test() {
    [[ $(candidate "7" "10") = "     7     " ]]
}

run_test
