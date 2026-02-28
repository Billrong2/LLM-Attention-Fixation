#!/bin/bash
# $1 is a string
# $2 is an integer
f() {
    text=$1
    length=$2
    length=$(( length < 0 ? -length : length ))
    output=""

    for (( idx=0; idx<length; idx++ )); do
        char=${text:$((idx % ${#text})):1}
        if [[ $char != ' ' ]]; then
            output="${output}${char}"
        else
            break
        fi
    done

    echo $output
}

candidate() {
    f "$@"
}

set -e
run_test() {
    [[ $(candidate "I got 1 and 0." "5") = "I" ]]
}

run_test
