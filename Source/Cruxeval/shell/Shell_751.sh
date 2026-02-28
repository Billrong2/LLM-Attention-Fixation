#!/bin/bash
# $1 is a string
# $2 is a string
# $3 is an integer
f() {
    count=$(grep -o $2 <<< $1 | wc -l)
    if [ $count -lt $3 ]; then
        echo $1 | tr '[:upper:][:lower:]' '[:lower:][:upper:]'
    else
        echo $1
    fi
}

candidate() {
    f "$@"
}

set -e
run_test() {
    [[ $(candidate "wwwwhhhtttpp" "w" "3") = "wwwwhhhtttpp" ]]
}

run_test
