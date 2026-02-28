#!/bin/bash
# $1 is a two column CSV in key,value order
f() {
    declare -A d
    while IFS=, read -r key value; do
        d["$key"]=$value
    done < <(echo -e "$1")

    sorted_keys=$(for k in "${!d[@]}"; do
        echo "$k,${d[$k]}"
    done | awk -F, '{print $1,$2,length($1""$2)}' | sort -k3,3n | awk '{print $1","$2}')

    result=()
    while IFS=, read -r k v; do
        if [ "$k" -lt "$v" ]; then
            result+=("$k $v")
        fi
    done <<< "$sorted_keys"

    for pair in "${result[@]}"; do
        echo "$pair"
    done
}

candidate() {
    f "$@"
}

set -e
run_test() {
    [[ $(candidate "55,4
4,555
1,3
99,21
499,4
71,7
12,6") = "1 3
4 555" ]]
}

run_test
