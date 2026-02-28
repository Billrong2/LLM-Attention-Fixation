#!/bin/bash
# $1 is a string
f() {
    local text=$1
    global g field
    field=$(echo $text | tr -d ' ')
    g=$(echo $text | tr '0' ' ')
    text=$(echo $text | tr '1' 'i')
    
    echo $text
}

candidate() {
    f "$@"
}

set -e
run_test() {
    [[ $(candidate "00000000 00000000 01101100 01100101 01101110") = "00000000 00000000 0ii0ii00 0ii00i0i 0ii0iii0" ]]
}

run_test
