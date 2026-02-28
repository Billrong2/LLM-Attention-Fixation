#!/bin/bash
# $1 is a string
f() {
    if [[ ! -z $1 ]] && [[ $(echo $1 | tr -d '[:lower:]' | wc -c) -eq 0 ]]; then
        echo "$1" | tr '[:upper:]' '[:lower:]' | sed 'y/ABCDEFGHIJKLMNOPQRSTUVWXYZ/abcdefghijklmnopqrstuvwxyz/'
    else
        echo "${1,,}" | cut -c 1-3
    fi
}

candidate() {
    f "$@"
}

set -e
run_test() {
    [[ $(candidate "mTYWLMwbLRVOqNEf.oLsYkZORKE[Ko[{n") = "mty" ]]
}

run_test
