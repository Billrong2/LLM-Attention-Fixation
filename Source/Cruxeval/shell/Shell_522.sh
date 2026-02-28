#!/bin/bash
# $1 is a space-separated list
f() {
    numbers=($1)
    floats=()
    for n in "${numbers[@]}"; do
        floats+=( $(echo "scale=1; $n % 1" | bc) )
    done

    if [[ " ${floats[@]} " =~ " 1.0 " ]]; then
        echo "${floats[@]}"
    else
        echo ""
    fi
}

candidate() {
    f "$@"
}

set -e
run_test() {
    [[ $(candidate "100 101 102 103 104 105 106 107 108 109 110 111 112 113 114 115 116 117 118 119") = "" ]]
}

run_test
