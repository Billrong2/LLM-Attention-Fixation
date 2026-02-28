#!/bin/bash
# $1 is a two column CSV in key,value order
f() {
    while IFS=, read key value; do
        result["$value"]=$(echo "$value" | cut -d '.' -f 1)'@pinc.uk'
    done < "$1"
    for key in "${!result[@]}"; do
        echo "$key,${result[$key]}"
    done
}

candidate() {
    f "$@"
}

set -e
run_test() {
    [[ $(candidate "") = "" ]]
}

run_test
