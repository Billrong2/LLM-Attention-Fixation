#!/bin/bash
# $1 is a space-separated list
f() {
    local lines=($1)
    local last_line=${lines[-1]}
    local result=()

    for line in "${lines[@]}"; do
        result+=("$(printf "%s" "$line" | awk -v len=${#last_line} '{printf "%*s\n", len, $0}')")
    done

    echo "${result[@]}"
}

candidate() {
    f "$@"
}

set -e
run_test() {
    [[ $(candidate "dZwbSR wijHeq qluVok dxjxbF") = "dZwbSR wijHeq qluVok dxjxbF" ]]
}

run_test
