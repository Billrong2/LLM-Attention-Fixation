#!/bin/bash
# $1 is a string
f() {
    if [[ $1 =~ ^[a-zA-Z0-9]*$ ]]; then
        echo "ascii encoded is allowed for this language"
    else
        echo "more than ASCII"
    fi
}

candidate() {
    f "$@"
}

set -e
run_test() {
    [[ $(candidate "Str zahrnuje anglo-ameriæske vasi piscina and kuca\!") = "more than ASCII" ]]
}

run_test
