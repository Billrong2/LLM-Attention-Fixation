#!/bin/bash
# $1 is a space-separated list
# $2 is an integer
f() {
    zero_count=$(tr -s ' ' <<< $1 | grep -o '0' | wc -l)
    target_count=$(tr -s ' ' <<< $1 | grep -o $2 | wc -l)
    
    if [[ $zero_count -gt 0 ]]; then
        echo 0
    elif [[ $target_count -lt 3 ]]; then
        echo 1
    else
        echo $(awk -v t=$2 '$1==t {print NR; exit}' <<< $1)
    fi
}

candidate() {
    f "$@"
}

set -e
run_test() {
    [[ $(candidate "1 1 1 2" "3") = "1" ]]
}

run_test
