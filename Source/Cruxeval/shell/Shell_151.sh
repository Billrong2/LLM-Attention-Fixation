#!/bin/bash
# $1 is a string
f() {
    text=$1
    new_text=""
    for ((i=0; i<${#text}; i++)); do
        char="${text:$i:1}"
        if [[ $char =~ ^[0-9]+$ ]]; then
            if [ "$char" -eq 0 ]; then
                char="."
            else
                if [ "$char" -eq 1 ]; then
                    char="0"
                fi
            fi
        fi
        new_text+=$char
    done
    echo $new_text | tr '.' '0'
}

candidate() {
    f "$@"
}

set -e
run_test() {
    [[ $(candidate "697 this is the ultimate 7 address to attack") = "697 this is the ultimate 7 address to attack" ]]
}

run_test
