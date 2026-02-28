#!/bin/bash
# $1 is a string
f() {
    text=$(echo "$1" | tr -d '-')
    text=$(echo "$text" | tr '[:upper:]' '[:lower:]')

    declare -A d
    for ((i=0; i<${#text}; i++)); do
        char=${text:$i:1}
        if [ -n "${d[$char]}" ]; then
            d[$char]=$((${d[$char]}+1))
        else
            d[$char]=1
        fi
    done

    sorted=$(for key in "${!d[@]}"; do
        echo "$key:${d[$key]}"
    done | sort -t':' -k2)

    result=()
    while IFS=: read -r char count; do
        result+=($count)
    done <<< "$sorted"

    echo "${result[@]}"
}

candidate() {
    f "$@"
}

set -e
run_test() {
    [[ $(candidate "x--y-z-5-C") = "1 1 1 1 1" ]]
}

run_test
