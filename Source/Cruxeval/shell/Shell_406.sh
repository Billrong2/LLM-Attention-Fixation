#!/bin/bash
# $1 is a string
f() {
    firstChar=$(echo $1 | cut -c1 | tr '[:lower:]' '[:upper:]')
    lastChar=$(echo $1 | rev | cut -c1 | tr '[:lower:]' '[:upper:]')
    modifiedString=${lastChar}$(echo $1 | cut -c2- | rev | cut -c2-)${firstChar}
    
    if [[ "$(echo $modifiedString | sed -r 's/([^ ])([[:upper:]])/\1 \2/g')" == "$modifiedString" ]]; then
        echo true
    else
        echo false
    fi
}

candidate() {
    f "$@"
}

set -e
run_test() {
    [[ $(candidate "Josh") = "false" ]]
}

run_test
