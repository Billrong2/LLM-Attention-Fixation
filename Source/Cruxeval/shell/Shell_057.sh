#!/bin/bash
# $1 is a string
f() {
    upper_text=$(echo "$1" | tr '[:lower:]' '[:upper:]')
    count_upper=0
    for ((i=0; i<${#upper_text}; i++)); do
        char=${upper_text:$i:1}
        if [[ $char == [A-Z] ]]; then
            ((count_upper++))
        else
            echo 'no'
            return
        fi
    done
    echo $((count_upper / 2))
}

candidate() {
    f "$@"
}

set -e
run_test() {
    [[ $(candidate "ax") = "1" ]]
}

run_test
