#!/bin/bash
# $1 is a string
f() {
    new_text=""
    for ch in $(echo "$1" | tr '[:upper:]' '[:lower:]' | tr -d '[:space:]'); do
        if [[ $ch =~ [0-9] || $ch =~ [ÄäÏïÖöÜü] ]]; then
            new_text="${new_text}${ch}"
        fi
    done
    echo $new_text
}

candidate() {
    f "$@"
}

set -e
run_test() {
    [[ $(candidate "") = "" ]]
}

run_test
