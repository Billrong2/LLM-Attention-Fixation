#!/bin/bash
# $1 is a string
# $2 is a string
f() {
    str=$1
    char=$2
    len=${#str}
    index=-1
    for (( i=0; i<len; i++ )); do
        if [ "${str:$i:1}" = "$char" ]; then
            index=$i
        fi
    done
    echo $index
}

candidate() {
    f "$@"
}

set -e
run_test() {
    [[ $(candidate "breakfast" "e") = "2" ]]
}

run_test
