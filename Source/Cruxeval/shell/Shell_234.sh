#!/bin/bash
# $1 is a string
# $2 is a string
f() {
    text=$1
    char=$2
    position=${#text}
    if [[ $text == *$char* ]]; then
        position=$(awk -v a="$text" -v b="$char" 'BEGIN{print index(a,b)-1}')
        if [[ $position -gt 1 ]]; then
            position=$(( ($position + 1) % ${#text} ))
        fi
    fi
    echo $position
}

candidate() {
    f "$@"
}

set -e
run_test() {
    [[ $(candidate "wduhzxlfk" "w") = "0" ]]
}

run_test
