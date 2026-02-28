#!/bin/bash
# $1 is a string
# $2 is a two column CSV in key,value order
f() {
    local out=$1
    local mapping=($2)

    for key in "${!mapping[@]}"; do
        out=$(echo "$out" | sed "s/{$key}/${mapping[$key]}/g")
        if [[ $(echo "$out" | grep -o '{\w}' | wc -l) -eq 0 ]]; then
            break
        fi
        reversed=$(echo "${mapping[$key]}" | rev)
        mapping[$key]=$reversed
    done

    echo "$out"
}

candidate() {
    f "$@"
}

set -e
run_test() {
    [[ $(candidate "{{{{}}}}" "") = "{{{{}}}}" ]]
}

run_test
