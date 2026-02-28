#!/bin/bash
# $1 is a string
# $2 is an integer
f() {
    text=$1
    position=$2
    length=${#text}
    index=$((position % (length + 1)))
    if ((position < 0)) || ((index < 0)); then
        index=-1
    fi
    new_text=$(echo "$text" | sed -r "s/^(.{$index}).{0,1}(.*)$/\1\2/")
    echo $new_text
}

candidate() {
    f "$@"
}

set -e
run_test() {
    [[ $(candidate "undbs l" "1") = "udbs l" ]]
}

run_test
