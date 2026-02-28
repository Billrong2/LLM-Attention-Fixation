#!/bin/bash
# $1 is a string
# $2 is a string
# $3 is an integer
f() {
    txt=$1
    sep=$2
    sep_count=$3
    o=''

    while [ $sep_count -gt 0 ] && [ $(echo "$txt" | grep -o "$sep" | wc -l) -gt 0 ]; do
        o+=$(echo "$txt" | rev | cut -d "$sep" -f 2- | rev)"$sep"
        txt=$(echo "$txt" | rev | cut -d "$sep" -f 1 | rev)
        sep_count=$((sep_count-1))
    done

    echo "$o$txt"
}

candidate() {
    f "$@"
}

set -e
run_test() {
    [[ $(candidate "i like you" " " "-1") = "i like you" ]]
}

run_test
