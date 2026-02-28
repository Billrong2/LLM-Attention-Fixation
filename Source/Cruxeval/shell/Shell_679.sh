#!/bin/bash
# $1 is a string
f() {
    if [ -z "$1" ]; then
        echo "false"
        return
    fi

    first_char=${1:0:1}
    if [[ $first_char =~ [0-9] ]]; then
        echo "false"
        return
    fi

    for (( i=0; i<${#1}; i++ )); do
        last_char=${1:i:1}
        if [ "$last_char" != "_" ] && ! [[ $last_char =~ [[:alnum:]_] ]]; then
            echo "false"
            return
        fi
    done
    
    echo "true"
}

candidate() {
    f "$@"
}

set -e
run_test() {
    [[ $(candidate "meet") = "true" ]]
}

run_test
