#!/bin/bash
# $1 is a string
# $2 is a string
# $3 is a string
f() {
    char1="${2}"
    char2="${3}"
    t1a=()
    t2a=()
    for ((i=0; i<${#char1}; i++)); do
        t1a+=("${char1:i:1}")
        t2a+=("${char2:i:1}")
    done
    declare -A t1
    for ((i=0; i<${#t1a[@]}; i++)); do
        t1["${t1a[i]}"]="${t2a[i]}"
    done
    result=""
    for ((i=0; i<${#1}; i++)); do
        if [[ -n ${t1[${1:i:1}]} ]]; then
            result+="${t1[${1:i:1}]}"
        else
            result+="${1:i:1}"
        fi
    done
    echo "${result}"
}

candidate() {
    f "$@"
}

set -e
run_test() {
    [[ $(candidate "ewriyat emf rwto segya" "tey" "dgo") = "gwrioad gmf rwdo sggoa" ]]
}

run_test
