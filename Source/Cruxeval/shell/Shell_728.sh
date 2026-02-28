#!/bin/bash
# $1 is a string
f() {
    result=""
    text=$1
    for (( i=0; i<${#text}; i++ )); do
        ch=${text:$i:1}
        if [[ $ch != ${ch,,} ]]; then
            if (( ${#text} - 1 - i < $(expr index "$text" ${ch,,}) )); then
                result+=${ch}
            fi
        fi
    done
    echo $result
}

candidate() {
    f "$@"
}

set -e
run_test() {
    [[ $(candidate "ru") = "" ]]
}

run_test
