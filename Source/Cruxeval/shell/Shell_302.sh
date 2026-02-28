#!/bin/bash
# $1 is a string
f() {
    echo $1 | sed 's/needles/haystacks/g'
}

candidate() {
    f "$@"
}

set -e
run_test() {
    [[ $(candidate "wdeejjjzsjsjjsxjjneddaddddddefsfd") = "wdeejjjzsjsjjsxjjneddaddddddefsfd" ]]
}

run_test
