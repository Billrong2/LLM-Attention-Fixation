#!/bin/bash
# $1 is a string
# $2 is an integer
f() {
    num=$1
    l=$2
    t=""
    
    while [ $l -gt ${#num} ]
    do
        t+='0'
        l=$(( $l - 1 ))
    done
    
    echo $t$num
}

candidate() {
    f "$@"
}

set -e
run_test() {
    [[ $(candidate "1" "3") = "001" ]]
}

run_test
