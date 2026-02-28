#!/bin/bash
# $1 is a string
# $2 is a string
f() {
    t=$1
    for (( i=0; i<${#t}; i++ )); do
        t=${t//"${t:$i:1}"/""}
    done
    echo $t | tr "$2" "\n" | wc -l
}

candidate() {
    f "$@"
}

set -e
run_test() {
    [[ $(candidate "c, c, c ,c, c" "c") = "1" ]]
}

run_test
