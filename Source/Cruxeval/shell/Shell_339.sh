#!/bin/bash
# $1 is a space-separated list
# $2 is an integer
f() {
    local array=($1)
    local elem=$2
    local d=0
    for i in "${array[@]}"; do
        if [ "$i" == "$elem" ]; then
            ((d++))
        fi
    done
    echo $d
}

candidate() {
    f "$@"
}

set -e
run_test() {
    [[ $(candidate "-1 2 1 -8 -8 2" "2") = "2" ]]
}

run_test
