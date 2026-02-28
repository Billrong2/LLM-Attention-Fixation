#!/bin/bash
# $1 is a string
# $2 is an integer
# $3 is a string
f() {
    text=$1
    position=$2
    value=$3
    length=${#text}
    index=$((position % length))
    
    if [ $position -lt 0 ]; then
        index=$((length / 2))
    fi
    
    new_text=($(echo "$text" | grep -o .))
    new_text=("${new_text[@]:0:index}" "$value" "${new_text[@]:index}")
    unset 'new_text[length-1]'
    
    echo "${new_text[@]}" | tr -d ' '
}

candidate() {
    f "$@"
}

set -e
run_test() {
    [[ $(candidate "sduyai" "1" "y") = "syduyi" ]]
}

run_test
