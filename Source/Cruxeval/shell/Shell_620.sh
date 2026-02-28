#!/bin/bash
# $1 is a string
f() {
    local input="$1"
    local reversed=""
    for (( i=${#input}-1; i>=0; i-- )); do
        reversed="$reversed${input:$i:1} "
    done
    echo "${reversed% }"  # Remove the trailing space
}

candidate() {
    f "$@"
}

set -e
run_test() {
    [[ $(candidate "lert dna ndqmxohi3") = "3 i h o x m q d n   a n d   t r e l" ]]
}

run_test
