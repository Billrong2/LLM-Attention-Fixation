#!/bin/bash
# $1 is a space-separated list
f() {
    strands=($1)
    subs=("${strands[@]}")
    for ((i=0; i<${#subs[@]}; i++)); do
        for ((k=0; k<${#subs[i]}/2; k++)); do
            first=${subs[i]::1}
            middle=${subs[i]:1:-1}
            last=${subs[i]: -1}
            subs[i]=$last$middle$first
        done
    done
    result=$(IFS=''; echo "${subs[*]}")
    echo $result
}

candidate() {
    f "$@"
}

set -e
run_test() {
    [[ $(candidate "__ 1 . 0 r0 __ a_j 6 __ 6") = "__1.00r__j_a6__6" ]]
}

run_test
