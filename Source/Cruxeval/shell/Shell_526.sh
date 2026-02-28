#!/bin/bash
# $1 is a string
# $2 is a string
# $3 is a string
# $4 is an integer
f() {
    m=$(expr index "$1" "$2")
    if [ $m -ge $4 ]; then
        echo ${3:0:m-$4+1}
    else
        echo $1${3:$4-m-1}
    fi
}

candidate() {
    f "$@"
}

set -e
run_test() {
    [[ $(candidate "ekwies" "s" "rpg" "1") = "rpg" ]]
}

run_test
