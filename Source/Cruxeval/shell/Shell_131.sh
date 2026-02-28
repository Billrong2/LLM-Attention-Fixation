#!/bin/bash
# $1 is a string
f() {
    text=$1
    a=${#text}
    count=0
    while [ "$text" != "" ]; do
        if [[ $text == a* ]]; then
            count=$((count + $(expr index "$text" ' ') - 1))
        else
            count=$((count + $(expr index "$text" '\n') - 1))
        fi
        text=${text#*\\n}
        text=${text:0:a}
    done
    echo $count
}

candidate() {
    f "$@"
}

set -e
run_test() {
    [[ $(candidate "a\nkgf\nasd\n") = "1" ]]
}

run_test
