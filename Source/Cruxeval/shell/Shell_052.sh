#!/bin/bash
# $1 is a string
f() {
    text=$1
    a=""
    for (( i=0; i<${#text}; i++ )); do
        if [[ ! ${text:$i:1} =~ [0-9] ]]; then
            a+=${text:$i:1}
        fi
    done
    echo $a
}

candidate() {
    f "$@"
}

set -e
run_test() {
    [[ $(candidate "seiq7229 d27") = "seiq d" ]]
}

run_test
