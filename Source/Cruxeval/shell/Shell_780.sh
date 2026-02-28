#!/bin/bash
# $1 is a space-separated list
f() {
    local counts
    counts=($(for i in $1; do echo 0; done))

    for i in $1; do
        counts[$i]=$((${counts[$i]} + 1))
    done

    local r
    for i in $(seq 0 300); do
        if [ ${counts[$i]} -ge 3 ]; then
            r+=($i)
        fi
    done

    counts=()
    echo "${r[@]}"
}

candidate() {
    f "$@"
}

set -e
run_test() {
    [[ $(candidate "2 3 5 2 4 5 2 89") = "2" ]]
}

run_test
