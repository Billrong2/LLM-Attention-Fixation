#!/bin/bash
# $1 is a string
f() {
    if [ "$1" = "" ]; then
        echo ""
    else
        result=$(echo $1 | tr -d '()' | sed 's/ //g' | awk '{print tolower($0)}')
        echo ${result^}
    fi
}

candidate() {
    f "$@"
}

set -e
run_test() {
    [[ $(candidate "(A (b B))") = "Abb" ]]
}

run_test
