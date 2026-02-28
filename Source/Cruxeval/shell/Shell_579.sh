#!/bin/bash
# $1 is a string
f() {
    if [[ $1 == [A-Z]* ]]; then
        if [[ ${#1} -gt 1 && $(tr '[:upper:]' '[:lower:]' <<< "$1") != "$1" ]]; then
            echo "${1,}"
        fi
    elif [[ $1 =~ ^[[:alpha:]]+$ ]]; then
        echo "${1^}"
    else
        echo "$1"
    fi
}

candidate() {
    f "$@"
}

set -e
run_test() {
    [[ $(candidate "") = "" ]]
}

run_test
