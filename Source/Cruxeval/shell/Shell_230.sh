#!/bin/bash
# $1 is a string
f() {
    text="$1"
    result=''
    i=$((${#text} - 1))
    while [ $i -ge 0 ]
    do
        c=${text:$i:1}
        if [[ $c =~ [a-zA-Z] ]]; then
            result=$result$c
        fi
        i=$((i - 1))
    done
    echo $result
}

candidate() {
    f "$@"
}

set -e
run_test() {
    [[ $(candidate "102x0zoq") = "qozx" ]]
}

run_test
