#!/bin/bash
# $1 is a string
f() {
    local result=""
    for (( i=0; i<${#1}; i++ )); do
        if [[ ! $(echo "${1:i:1}" | grep -P '.*[^\x00-\x7F].*') ]]; then
            result="${result}$(echo "${1:i:1}" | tr '[:lower:]' '[:upper:]')"
        else
            result="${result}${1:i:1}"
        fi
    done
    echo $result
}

candidate() {
    f "$@"
}

set -e
run_test() {
    [[ $(candidate "ua6hajq") = "UA6HAJQ" ]]
}

run_test
