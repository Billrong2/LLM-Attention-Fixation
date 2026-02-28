#!/bin/bash
# $1 is a string
f() {
    if [[ $(echo $1 | tr '[:upper:]' '[:lower:]' | awk '{print index($0, "i")}') -gt $(echo $1 | tr '[:upper:]' '[:lower:]' | awk '{print rindex($0, "i")}') ]]; then
        echo 'Hey'
    else
        echo 'Hi'
    fi
}

candidate() {
    f "$@"
}

set -e
run_test() {
    [[ $(candidate "Hi there") = "Hey" ]]
}

run_test
