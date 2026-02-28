#!/bin/bash
# $1 is a string
f() {
    new_text=$(echo $1 | sed 's/./\U&/g')
    echo $new_text
}

candidate() {
    f "$@"
}

set -e
run_test() {
    [[ $(candidate "dst vavf n dmv dfvm gamcu dgcvb.") = "DST VAVF N DMV DFVM GAMCU DGCVB." ]]
}

run_test
