#!/bin/bash
# $1 is a string
# $2 is a string
f() {
    text="$1"
    delim="$2"
    rev_text=$(echo "$text" | rev)
    delim_pos="${rev_text%%$delim*}"
    delim_pos_in_text="${#delim_pos}"
    prefix=${text:0:$delim_pos_in_text}
    echo "$prefix" | rev
}

candidate() {
    f "$@"
}

set -e
run_test() {
    [[ $(candidate "dsj osq wi w" " ") = "d" ]]
}

run_test
