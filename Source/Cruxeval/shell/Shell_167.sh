#!/bin/bash
# $1 is a string
# $2 is a string
f() {
    XAAXX=$1
    s=$2
    count=0
    idx=-1
    while [[ $(echo $XAAXX | awk -F"XXXX" '{print NF-1}') -gt $count ]]; do
        count=$((count+1))
    done
    compound=$(echo $s | tr '[:lower:]' '[:upper:]' | head -c 1)$(echo $s | tr '[:upper:]' '[:lower:]' | tail -c +2)
    for i in $(seq 2 $count); do
        compound=$compound$(echo $s | tr '[:lower:]' '[:upper:]' | head -c 1)$(echo $s | tr '[:upper:]' '[:lower:]' | tail -c +2)
    done
    XAAXX=$(echo $XAAXX | sed "s/XXXX/$compound/g")
    echo $XAAXX
}

candidate() {
    f "$@"
}

set -e
run_test() {
    [[ $(candidate "aaXXXXbbXXXXccXXXXde" "QW") = "aaQwQwQwbbQwQwQwccQwQwQwde" ]]
}

run_test
