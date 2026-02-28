#!/bin/bash
# $1 is a string
f() {
    echo $(( ${#1} - $(echo $1 | grep -o 'bot' | wc -l) ))
}

candidate() {
    f "$@"
}

set -e
run_test() {
    [[ $(candidate "Where is the bot in this world?") = "30" ]]
}

run_test
