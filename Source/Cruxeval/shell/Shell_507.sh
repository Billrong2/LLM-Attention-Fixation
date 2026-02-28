#!/bin/bash
# $1 is a string
# $2 is a string
f() {
    result=$(echo "$1" | tr '[:upper:]' '[:lower:]')
    echo $(echo $result | grep -b -o -i "$2" | head -n1 | cut -d: -f1)
}

candidate() {
    f "$@"
}

set -e
run_test() {
    [[ $(candidate "car hat" "car") = "0" ]]
}

run_test
