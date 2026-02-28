#!/bin/bash
# $1 is a string
# $2 is a string
f() {
    local text="$1"
    local ch="$2"
    local count=$(echo "$text" | grep -o "$ch" | wc -l)
    echo $count
}

candidate() {
    f "$@"
}

set -e
run_test() {
    [[ $(candidate "This be Pirate's Speak for 'help'\!" " ") = "5" ]]
}

run_test
