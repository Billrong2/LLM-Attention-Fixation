#!/bin/bash
# $1 is a string
f() {
    nums=$(echo $1 | tr -cd '[:digit:]')
    if [ -n "$nums" ]; then
        echo $nums
    else
        echo "Error: No numeric characters found"
        exit 1
    fi
}

candidate() {
    f "$@"
}

set -e
run_test() {
    [[ $(candidate "-123   	+314") = "123314" ]]
}

run_test
