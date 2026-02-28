#!/bin/bash
# $1 is a string
f() {
    count=0
    for word in $1
    do
        first_char=${word:0:1}
        rest_chars=${word:1}
        # Check if first character is uppercase and rest of the characters are lowercase
        if [[ $first_char =~ [A-Z] ]] && [[ $rest_chars =~ ^[a-z]*$ ]]
        then
            ((count++))
        fi
    done
    echo $count
}

candidate() {
    f "$@"
}

set -e
run_test() {
    [[ $(candidate "SOME OF THIS Is uknowN\!") = "1" ]]
}

run_test
