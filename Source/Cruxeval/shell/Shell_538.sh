#!/bin/bash
# $1 is a string
# $2 is an integer
f() {
    text=$1
    width=$2

    if [ ${#text} -gt $width ]; then
        text=${text:0:$width}
    fi

    while [ ${#text} -lt $width ]; do
        text="z${text}z"
        if [ ${#text} -gt $width ]; then
            text=${text:0:$width}
        fi
    done

    echo $text
}

candidate() {
    f "$@"
}

set -e
run_test() {
    [[ $(candidate "0574" "9") = "zzz0574zz" ]]
}

run_test
