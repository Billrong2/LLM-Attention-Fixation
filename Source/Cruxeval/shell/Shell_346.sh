#!/bin/bash
# $1 is a string
f() {
    filename=$1
    suffix=${filename##*.}
    f2=$filename$(echo $suffix | rev)
    if [[ $f2 == *$suffix ]]; then
        echo true
    else
        echo false
    fi
}

candidate() {
    f "$@"
}

set -e
run_test() {
    [[ $(candidate "docs.doc") = "false" ]]
}

run_test
