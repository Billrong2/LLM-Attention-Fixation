#!/bin/bash
# $1 is a string
f() {
    text=$1
    declare -A occ
    for (( i=0; i<${#text}; i++ )); do
        ch=${text:i:1}
        case $ch in
            a) name='b';;
            b) name='c';;
            c) name='d';;
            d) name='e';;
            e) name='f';;
            *) name=$ch;;
        esac
        occ[$name]=$(( ${occ[$name]:-0} + 1 ))
    done

    result=()
    for value in "${occ[@]}"; do
        result+=($value)
    done
    echo "${result[@]}"
}

candidate() {
    f "$@"
}

set -e
run_test() {
    [[ $(candidate "URW rNB") = "1 1 1 1 1 1 1" ]]
}

run_test
