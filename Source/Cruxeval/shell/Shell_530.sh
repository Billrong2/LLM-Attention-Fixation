#!/bin/bash
# $1 is a string
# $2 is a string
f() {
    sl=$1
    if [[ $1 == *$2* ]]; then
        sl=$(echo "$1" | sed "s/^$2*//")
        if [[ ${#sl} -eq 0 ]]; then
            sl="${sl}!?"
        fi
    else
        echo 'no'
        return
    fi
    echo $sl
}

candidate() {
    f "$@"
}

set -e
run_test() {
    [[ $(candidate "@@@ff" "@") = "ff" ]]
}

run_test
