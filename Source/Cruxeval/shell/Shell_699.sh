#!/bin/bash
# $1 is a string
# $2 is a string
f() {
    text=$1
    elem=$2

    if [ "$elem" != "" ]; then
        while [[ $text == $elem* ]]; do
            text=${text//$elem/}
        done
        while [[ $elem == $text* ]]; do
            elem=${elem//$text/}
        done
    fi

    echo "$elem $text"
}

candidate() {
    f "$@"
}

set -e
run_test() {
    [[ $(candidate "some" "1") = "1 some" ]]
}

run_test
