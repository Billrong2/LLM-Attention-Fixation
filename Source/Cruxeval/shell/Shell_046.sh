#!/bin/bash
# $1 is a space-separated list
# $2 is a string
f() {
    local IFS=$' '   # Set the internal field separator to space
    local l=($1)     # Convert space-separated list to array
    local result=$(IFS=$2; echo "${l[*]}")
    echo "$result"
}

candidate() {
    f "$@"
}

set -e
run_test() {
    [[ $(candidate "many letters asvsz hello man" "") = "manylettersasvszhelloman" ]]
}

run_test
