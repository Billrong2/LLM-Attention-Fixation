#!/bin/bash
# $1 is a string
# $2 is a string
f() {
    char_index=$(expr index "$1" "$2")
    result=""
    if [ $char_index -gt 0 ]; then
        result=$(echo "$1" | cut -c 1-$((char_index-1)))
    fi
    result="$result$2$(echo "$1" | cut -c $((char_index+${#2}))-)"
    echo $result
}

candidate() {
    f "$@"
}

set -e
run_test() {
    [[ $(candidate "llomnrpc" "x") = "xllomnrpc" ]]
}

run_test
