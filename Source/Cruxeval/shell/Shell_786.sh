#!/bin/bash
# $1 is a string
# $2 is a string
f() {
    text=$1
    letter=$2
    if [[ $text == *"$letter"* ]]; then
        start=$(awk -v a="$text" -v b="$letter" 'BEGIN{print index(a,b)}')
        echo ${text:$start}${text:0:$start}
    else
        echo $text
    fi
}

candidate() {
    f "$@"
}

set -e
run_test() {
    [[ $(candidate "19kefp7" "9") = "kefp719" ]]
}

run_test
