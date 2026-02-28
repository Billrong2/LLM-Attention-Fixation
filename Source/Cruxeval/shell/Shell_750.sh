#!/bin/bash
# $1 is a two column CSV in key,value order
# $2 is a string
f() {
    local char_map=$1
    local text=$2
    local new_text=""

    IFS=','
    while read -r key value; do
        char_map["$key"]=$value
    done <<< "$char_map"

    for ((i=0; i<${#text}; i++)); do
        ch="${text:i:1}"
        val=${char_map[$ch]}
        if [ -z "$val" ]; then
            new_text+="$ch"
        else
            new_text+="$val"
        fi
    done

    echo "$new_text"
}

candidate() {
    f "$@"
}

set -e
run_test() {
    [[ $(candidate "" "hbd") = "hbd" ]]
}

run_test
