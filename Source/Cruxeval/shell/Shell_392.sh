#!/bin/bash
# $1 is a string
f() {
    if [ "$1" = "$(echo $1 | tr '[:lower:]' '[:upper:]')" ]; then
        echo "ALL UPPERCASE"
    else
        echo $1
    fi
}

candidate() {
    f "$@"
}

set -e
run_test() {
    [[ $(candidate "Hello Is It MyClass") = "Hello Is It MyClass" ]]
}

run_test
