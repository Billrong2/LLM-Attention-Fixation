#!/bin/bash
# $1 is a two column CSV in key,value order
f() {
    result=()
    IFS=$'\n'
    for line in $1; do
        key=$(echo "$line" | cut -d',' -f1)
        value=$(echo "$line" | cut -d',' -f2)
        result+=("$key:$value")
    done
    
    echo "${result[@]}"
}

candidate() {
    f "$@"
}

set -e
run_test() {
    [[ $(candidate "") = "" ]]
}

run_test
