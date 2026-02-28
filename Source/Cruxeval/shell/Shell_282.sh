#!/bin/bash
# $1 is a string
# $2 is a string
f() {
    s1=$1
    s2=$2
    position=1
    count=0
    while [ $position -gt 0 ]; do
        position=$(awk -v a="$s1" -v b="$s2" 'BEGIN{print index(a,b)}')
        let count++
        s1=${s1:position}
    done
    echo $count
}

candidate() {
    f "$@"
}

set -e
run_test() {
    [[ $(candidate "xinyyexyxx" "xx") = "2" ]]
}

run_test
