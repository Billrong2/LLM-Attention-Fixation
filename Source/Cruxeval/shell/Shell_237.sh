#!/bin/bash
# $1 is a string
# $2 is a string
f() {
    if [[ $1 == *$2* ]]; then
        suff=$(echo "$1" | awk -F "$2" '{print $1}')
        pref=$(echo "$1" | awk -F "$2" '{print $2}')
        char=$2
        pref=$(echo "${suff%$char}${suff#*$char}$char$pref")
        echo "$suff$char$pref"
    else
        echo "$1"
    fi
}

candidate() {
    f "$@"
}

set -e
run_test() {
    [[ $(candidate "uzlwaqiaj" "u") = "uuzlwaqiaj" ]]
}

run_test
