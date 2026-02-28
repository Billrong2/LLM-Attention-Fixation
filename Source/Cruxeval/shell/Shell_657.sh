#!/bin/bash
# $1 is a string
f() {
    text=$1
    for punct in '!.?,:;'
    do
        if [ $(echo $text | tr -cd $punct | wc -c) -gt 1 ]; then
            echo 'no'
            return
        fi
        if [[ $text == *"$punct" ]]; then
            echo 'no'
            return
        fi
    done
    echo $text | awk '{print toupper(substr($0,1,1)) tolower(substr($0,2))}'
}

candidate() {
    f "$@"
}

set -e
run_test() {
    [[ $(candidate "djhasghasgdha") = "Djhasghasgdha" ]]
}

run_test
