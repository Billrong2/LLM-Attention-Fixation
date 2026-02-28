#!/bin/bash
# $1 is a string
# $2 is a string
# $3 is a string
f() {
    text2=${1//$2/$3}
    old2=$(echo $2 | rev)
    while [[ $text2 == *"$old2"* ]]; do
        text2=${text2//$old2/$3}
    done
    echo $text2
}

candidate() {
    f "$@"
}

set -e
run_test() {
    [[ $(candidate "some test string" "some" "any") = "any test string" ]]
}

run_test
