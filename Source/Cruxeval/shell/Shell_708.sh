#!/bin/bash
# $1 is a string
f() {
    local str="$1"
    local trimmed_str=$(echo "$str" | sed 's/[[:space:]]*$//')
    echo "$trimmed_str"
}

candidate() {
    f "$@"
}

set -e
run_test() {
    [[ $(candidate "    jcmfxv     ") = "    jcmfxv" ]]
}

run_test
