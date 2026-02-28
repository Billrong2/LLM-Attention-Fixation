#!/bin/bash
# $1 is a string
# $2 is an integer
f() {
    local text=$1
    local count=$2
    
    for (( i=0; i<count; i++ )); do
        text=$(echo $text | rev)
    done
    
    echo $text
}

candidate() {
    f "$@"
}

set -e
run_test() {
    [[ $(candidate "439m2670hlsw" "3") = "wslh0762m934" ]]
}

run_test
