#!/bin/bash
# $1 is a string
f() {
    local a=()
    local b=()
    
    IFS=$'\n' read -r -a a <<< "$1"
    for line in "${a[@]}"; do
        c=$(echo "$line" | sed 's/\t/    /g')
        b+=("$c")
    done
    
    echo "${b[*]}"
}

candidate() {
    f "$@"
}

set -e
run_test() {
    [[ $(candidate "			tab tab tabulates") = "            tab tab tabulates" ]]
}

run_test
