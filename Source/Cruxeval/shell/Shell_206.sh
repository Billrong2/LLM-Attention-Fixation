#!/bin/bash
# $1 is a string
f() {
    echo $1 | tr -s ' ' ' '
}

candidate() {
    f "$@"
}

set -e
run_test() {
    [[ $(candidate " h e l l o   w o r l d\! ") = "h e l l o w o r l d\!" ]]
}

run_test
