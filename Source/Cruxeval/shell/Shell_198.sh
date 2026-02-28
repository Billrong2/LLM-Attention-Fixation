#!/bin/bash

# $1 is a string
# $2 is a string
f() {
    local text="$1"
    local strip_chars="$2"
    local reversed=$(echo "$text" | rev)
    local stripped=$(echo "$reversed" | sed "s/^[$strip_chars]*//; s/[$strip_chars]*$//")
    echo "$stripped" | rev
}

candidate() {
    f "$@"
}

set -e
run_test() {
    [[ $(candidate "tcmfsmj" "cfj") = "tcmfsm" ]]
}

run_test
