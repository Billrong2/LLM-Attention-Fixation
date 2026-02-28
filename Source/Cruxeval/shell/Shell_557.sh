#!/bin/bash
# $1 is a string
f() {
    echo $1 | sed 's/\(.*\)ar\(.*\)/\1 ar \2/'
}

candidate() {
    f "$@"
}

set -e
run_test() {
    [[ $(candidate "xxxarmmarxx") = "xxxarmm ar xx" ]]
}

run_test
