#!/bin/bash
# $1 is a string
# $2 is a string
f() {
    text=$1
    changes=$2
    result=''
    count=0
    for (( i=0; i<${#text}; i++ )); do
        char=${text:$i:1}
        if [[ $char == 'e' ]]; then
            result+=$char
        else
            result+=${changes:$((count % ${#changes})):1}
            ((count++))
        fi
    done
    echo $result
}

candidate() {
    f "$@"
}

set -e
run_test() {
    [[ $(candidate "fssnvd" "yes") = "yesyes" ]]
}

run_test
