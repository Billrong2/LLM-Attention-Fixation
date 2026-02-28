#!/bin/bash
# $1 is a string
# $2 is a string
f() {
    count=0
    if [ -n "$2" ]; then
        count=${#2}
        text=$(for ((i=0; i<${#2}; i++)); do printf "%s" "$1"; done)
    fi
    echo $text | awk -v count=$count '{printf "%" (length($0) + count*2) "s\n", $0}' | sed 's/.$//' | sed 's/.$//'
}

candidate() {
    f "$@"
}

set -e
run_test() {
    [[ $(candidate "" "BC1ty") = "        " ]]
}

run_test
