#!/bin/bash
# $1 is a string
f() {
    local a=0
    local words=($1)
    for word in "${words[@]}"; do
        local padded_word=$(printf "%0*d" $(( ${#word} * 2 )) 0)
        a=$(( a + ${#padded_word} ))
    done
    echo $a
}

candidate() {
    f "$@"
}

set -e
run_test() {
    [[ $(candidate "999893767522480") = "30" ]]
}

run_test
