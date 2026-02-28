#!/bin/bash
# $1 is a string
# $2 is a string
# $3 is a string
f() {
    text=$1
    lower=$2
    upper=$3
    count=0
    new_text=""
    for (( i=0; i<${#text}; i++ )); do
        char=${text:$i:1}
        if [[ $char =~ [0-9] ]]; then
            char=$lower
        else
            char=$upper
        fi
        if [[ $char == "p" || $char == "C" ]]; then
            ((count++))
        fi
        new_text="${new_text}${char}"
    done
    echo "$count $new_text"
}

candidate() {
    f "$@"
}

set -e
run_test() {
    [[ $(candidate "DSUWeqExTQdCMGpqur" "a" "x") = "0 xxxxxxxxxxxxxxxxxx" ]]
}

run_test
