#!/bin/bash
# $1 is a string
# $2 is an integer
f() {
    text=$1
    amount=$2
    length=${#text}
    pre_text="|"
    
    if [ $amount -ge $length ]; then
        extra_space=$(( $amount - $length ))
        pre_text+="$(printf '%*s' $(( $extra_space / 2 )))"
        echo "$pre_text$text$pre_text"
    else
        echo "$text"
    fi
}

candidate() {
    f "$@"
}

set -e
run_test() {
    [[ $(candidate "GENERAL NAGOOR" "5") = "GENERAL NAGOOR" ]]
}

run_test
