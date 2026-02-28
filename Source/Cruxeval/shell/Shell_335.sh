#!/bin/bash
# $1 is a string
# $2 is a string
f() {
    new_text=$(echo $1 | sed "s/$2/?/g")
    echo $new_text | sed "s/?//g"
}

candidate() {
    f "$@"
}

set -e
run_test() {
    [[ $(candidate "sjbrlfqmw" "l") = "sjbrfqmw" ]]
}

run_test
