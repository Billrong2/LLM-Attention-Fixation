#!/bin/bash
# $1 is a string
f() {
    count=0
    for ((i=0; i<${#1}; i++)); do
        char=${1:$i:1}
        if [[ $(awk -v char="$char" '{print gsub(char,"")}' <<< "$1") -gt 1 ]]; then
            count=$((count+1))
        fi
    done
    echo $count
}

candidate() {
    f "$@"
}

set -e
run_test() {
    [[ $(candidate "abca dea ead") = "10" ]]
}

run_test
