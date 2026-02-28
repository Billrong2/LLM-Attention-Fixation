#!/bin/bash

f() {
    declare -A char_count
    for (( i=0; i<${#1}; i++ )); do
        char="${1:$i:1}"
        count=${char_count[$char]:-0}
        ((count++))
        char_count[$char]=$count
    done
    for key in "${!char_count[@]}"; do
        if [ "${char_count[$key]}" -gt 1 ]; then
            char_count[$key]=1
        fi
    done
    for key in "${!char_count[@]}"; do
        echo "$key,${char_count[$key]}"
    done
}

candidate() {
    f "$@"
}

set -e
run_test() {
    [[ $(candidate "a") = "a,1" ]]
}

run_test
