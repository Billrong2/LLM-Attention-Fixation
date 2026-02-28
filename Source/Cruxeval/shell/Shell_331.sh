#!/bin/bash
# $1 is a string
# $2 is a string
f() {
    strand=$1
    zmnc=$2
    poz=$(expr index "$strand" "$zmnc")
    while [ "$poz" -ne 0 ]; do
        strand=${strand:$poz}
        poz=$(expr index "$strand" "$zmnc")
    done
    rpoz=$(expr match "$strand" '.*\($zmnc\)')
    if [ "$rpoz" -ne 0 ]; then
        echo ${#strand}
    else
        echo -1
    fi
}

candidate() {
    f "$@"
}

set -e
run_test() {
    [[ $(candidate "" "abc") = "-1" ]]
}

run_test
