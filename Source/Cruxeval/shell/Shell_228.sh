#!/bin/bash
# $1 is a string
# $2 is a string
f() {
    echo $1 | tr '[:upper:]' '[:lower:]' | tr -s ' ' | tr ' ' $2
}

candidate() {
    f "$@"
}

set -e
run_test() {
    [[ $(candidate "LlTHH sAfLAPkPhtsWP" "#") = "llthh#saflapkphtswp" ]]
}

run_test
