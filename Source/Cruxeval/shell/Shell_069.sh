#!/bin/bash
# $1 is a two column CSV in key,value order
# $2 is a string
f() {
    value=$(echo $1 | awk -F ',' -v name="$2" '$1 == name {print $2}')
    if [ -n "$value" ]; then
        echo $value
    else
        echo "Name unknown"
    fi
}

candidate() {
    f "$@"
}

set -e
run_test() {
    [[ $(candidate "882afmfp,56" "6f53p") = "Name unknown" ]]
}

run_test
