#!/bin/bash
# $1 is a newline-separated, space-separated list
f() {
    local result=""
    for elem in $1; do
        if [[ ! "$elem" =~ [^[:ascii:]] || ( "$elem" =~ ^[0-9-]+$ && ! $(echo $elem | sed 's/-//g' | grep -P '[^[:ascii:]]') ) ]]; then
            result="$result $elem"
        fi
    done
    echo $result
}

candidate() {
    f "$@"
}

set -e
run_test() {
    [[ $(candidate "a b c") = "a b c" ]]
}

run_test
