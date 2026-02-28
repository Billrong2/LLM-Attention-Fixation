#!/bin/bash
# $1 is a string
# $2 is a string
f() {
    text=$1
    c=$2
    if [[ $text != *$c* ]]; then
        echo "Text has no $c"
        exit 1
    fi
    
    idx=$(expr index "$text" $c)
    idx=$(($idx - 1))
    echo "${text:0:idx}${text:idx+1}"
}

candidate() {
    f "$@"
}

set -e
run_test() {
    [[ $(candidate "uufhl" "l") = "uufh" ]]
}

run_test
