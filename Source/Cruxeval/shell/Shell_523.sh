#!/bin/bash
# $1 is a string
f() {
    text=$1
    new_text=""
    for (( i=${#text}-1; i>=0; i-- )); do
        if [[ "${text:$i:1}" == " " ]]; then
            new_text="&nbsp;${new_text}"
        else
            new_text="${text:$i:1}${new_text}"
        fi
    done
    echo "$new_text"
}

candidate() {
    f "$@"
}

set -e
run_test() {
    [[ $(candidate "   ") = "&nbsp;&nbsp;&nbsp;" ]]
}

run_test
