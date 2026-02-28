#!/bin/bash
# $1 is a string
# $2 is a string
f() {
    s=$1
    x=$2
    count=0
    while [[ "${s:0:${#x}}" == "$x" && $count -lt $((${#s}-${#x})) ]]; do
        s=${s:${#x}}
        count=$((count+${#x}))
    done
    echo $s
}

candidate() {
    f "$@"
}

set -e
run_test() {
    [[ $(candidate "If you want to live a happy life\! Daniel" "Daniel") = "If you want to live a happy life\! Daniel" ]]
}

run_test
