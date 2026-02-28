#!/bin/bash
# $1 is a string
# $2 is a string
f() {
    text=$1
    chars=$2

    if [ -n "$chars" ]; then
        text=$(echo $text | sed "s/[$chars]*$//")
    else
        text=$(echo $text | sed 's/[[:space:]]*$//')
    fi

    if [ -z "$text" ]; then
        echo '-'
    else
        echo $text
    fi
}

candidate() {
    f "$@"
}

set -e
run_test() {
    [[ $(candidate "new-medium-performing-application - XQuery 2.2" "0123456789-") = "new-medium-performing-application - XQuery 2." ]]
}

run_test
