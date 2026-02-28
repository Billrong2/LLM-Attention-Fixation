#!/bin/bash
# $1 is a string
f() {
    IFS=' ' read -ra arr <<< "$1"
    lines=$(for i in $(seq 0 3 $(( ${#arr[@]} - 1)))
    do
        echo -n "${arr[$i]} "
    done | sed 's/ $//')
    res=()
    for i in $(seq 0 $(( (${#arr[@]} - 1) / 3 - 1 ))); do
        start=$(( 3 * i + 1 ))
        end=$(( 3 * (i + 1) ))
        if [ $end -lt ${#arr[@]} ]; then
            res+=($(for j in $(seq $start $end); do echo -n "${arr[$j]} "; done | sed 's/ $//'))
        fi
    done
    echo $lines ${res[@]}
}

candidate() {
    f "$@"
}

set -e
run_test() {
    [[ $(candidate "echo hello\!\!\! nice\!") = "echo" ]]
}

run_test
