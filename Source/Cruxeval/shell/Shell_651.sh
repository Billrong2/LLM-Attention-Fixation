#!/bin/bash
# $1 is a string
# $2 is a string
f() {
    text=$1
    letter=$2

    if [[ "${letter}" == [a-z] ]]; then
        letter=$(echo $letter | tr '[:lower:]' '[:upper:]')
    fi

    new_text=$(echo $text | sed "s/$letter/$(echo $letter | tr '[:upper:]' '[:lower:]')/g")
    echo $new_text | awk '{print toupper(substr($0,1,1))tolower(substr($0,2))}'
}

candidate() {
    f "$@"
}

set -e
run_test() {
    [[ $(candidate "E wrestled evil until upperfeat" "e") = "E wrestled evil until upperfeat" ]]
}

run_test
