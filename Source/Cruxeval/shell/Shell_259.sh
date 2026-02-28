#!/bin/bash
# $1 is a string
f() {
    new_text=""
    for (( i=0; i<${#1}; i++ )); do
        character=${1:i:1}
        if [[ ${character} =~ [A-Z] ]]; then
            index=$(( ${#new_text} / 2 ))
            new_text="${new_text:0:$index}${character}${new_text:$index}"
        fi
    done

    if [ -z "$new_text" ]; then
        new_text="-"
    fi

    echo $new_text
}

candidate() {
    f "$@"
}

set -e
run_test() {
    [[ $(candidate "String matching is a big part of RexEx library.") = "RES" ]]
}

run_test
