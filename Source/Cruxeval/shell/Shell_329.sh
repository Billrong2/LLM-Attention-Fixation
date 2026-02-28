#!/bin/bash
# $1 is a string
f() {
    local text=$1
    for ((i=1; i<${#text}; i++)); do
        if [[ ${text:i:1} == $(echo "${text:i:1}" | tr '[:lower:]' '[:upper:]') && ${text:i-1:1} == $(echo "${text:i-1:1}" | tr '[:upper:]' '[:lower:]') ]]; then
            echo "true"
            return
        fi
    done
    echo "false"
}

candidate() {
    f "$@"
}

set -e
run_test() {
    [[ $(candidate "jh54kkk6") = "true" ]]
}

run_test
