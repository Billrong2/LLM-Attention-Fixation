#!/bin/bash
# $1 is a string
f() {
    s=${1//\"/}
    lst=($(echo $s | grep -o .))
    col=0
    count=1
    while [ $col -lt ${#lst[@]} ] && [[ "${lst[$col]}" == "." || "${lst[$col]}" == ":" || "${lst[$col]}" == "," ]]; do
        if [[ "${lst[$col]}" == "." ]]; then
            count=$(( ${lst[$col]} + 1 ))
        fi
        col=$((col + 1))
    done
    echo ${s:col+count}
}

candidate() {
    f "$@"
}

set -e
run_test() {
    [[ $(candidate "\"Makers of a Statement\"") = "akers of a Statement" ]]
}

run_test
