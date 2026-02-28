#!/bin/bash
# $1 is a string
# $2 is a string
# $3 is an integer
f() {
    text=$1
    fill=$2
    size=$3

    if [ $size -lt 0 ]; then
        size=$((-$size))
    fi

    text_length=${#text}
    
    if [ $text_length -gt $size ]; then
        echo ${text:$(($text_length - $size))}
    else
        printf "%-${size}s" "$text" | tr ' ' "$fill"
    fi
}

candidate() {
    f "$@"
}

set -e
run_test() {
    [[ $(candidate "no asw" "j" "1") = "w" ]]
}

run_test
