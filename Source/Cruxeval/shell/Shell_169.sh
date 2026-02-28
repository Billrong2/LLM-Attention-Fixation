#!/bin/bash
# $1 is a string
f() {
    local text=$1
    local total=$(( (${#text} - 1) * 2 ))
    local ls=($(echo $text | sed 's/./& /g'))
    for ((i=1; i<=total; i++)); do
        if [ $((i % 2)) -eq 1 ]; then
            ls+=('+')
        else
            ls=("+" "${ls[@]}")
        fi
    done
    local result=$(IFS=; echo "${ls[*]}")
    printf "%*s\n" $total "$result"
}

candidate() {
    f "$@"
}

set -e
run_test() {
    [[ $(candidate "taole") = "++++taole++++" ]]
}

run_test
