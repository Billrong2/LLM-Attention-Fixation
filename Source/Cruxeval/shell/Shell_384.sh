#!/bin/bash
# $1 is a string
# $2 is a string
f() {
    text=$1
    chars=$2
    
    for (( i=0; i<${#chars}; i++ )); do
        char="${chars:i:1}"
        text=$(echo $text | sed "s/$char//g")
    done
    
    echo $text
}

candidate() {
    f "$@"
}

set -e
run_test() {
    [[ $(candidate "asfdellos" "Ta") = "sfdellos" ]]
}

run_test
