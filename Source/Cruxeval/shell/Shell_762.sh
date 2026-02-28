#!/bin/bash
# $1 is a string
f() {
    text=$(echo $1 | tr '[:upper:]' '[:lower:]')
    capitalize=$(echo $text | sed 's/./\U&/')
    echo ${text:0:1}${capitalize:1}
}

candidate() {
    f "$@"
}

set -e
run_test() {
    [[ $(candidate "this And cPanel") = "this and cpanel" ]]
}

run_test
