#!/bin/bash

f() {
    declare -A r1 r2
    while IFS=',' read -r k v; do
        r1["$k"]="$v"
        r2["$k"]="$v"
    done <<< "$1"

    if [[ "${!r1[@]}" == "${r2[@]}" ]]; then
        echo "true" "$([[ "${r1[@]}" == "${r2[@]}" ]] && echo "true" || echo "false")"
    else
        echo "false" "$([[ "${r1[@]}" == "${r2[@]}" ]] && echo "true" || echo "false")"
    fi
}

candidate() {
    f "$@"
}

set -e
run_test() {
    [[ $(candidate "i,1
love,parakeets") = "false true" ]]
}

run_test
