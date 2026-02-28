#!/bin/bash
# $1 is a string
# $2 is a string
f() {
    local text=$1
    local char=$2

    if [ -n "$text" ]; then
        # Remove prefix if it matches the given character
        if [[ $text == "$char"* ]]; then
            text=${text#"$char"}
        fi

        # Remove prefix if it matches the last character of the string
        last_char=${text: -1}
        if [[ $text == "$last_char"* ]]; then
            text=${text#"$last_char"}
        fi

        # Capitalize the last character
        text=${text:0:${#text}-1}$(echo "${text: -1}" | tr '[:lower:]' '[:upper:]')
    fi

    echo "$text"
}

candidate() {
    f "$@"
}

set -e
run_test() {
    [[ $(candidate "querist" "u") = "querisT" ]]
}

run_test
