#!/bin/bash
# $1 is a string
# $2 is an integer
f() {
    letters=$1
    maxsplit=$2
    word_count=$(echo $letters | wc -w)
    if (( maxsplit > word_count )); then
        maxsplit=$word_count
    fi
    echo $letters | awk -v maxsplit="$maxsplit" '{for(i=NF-maxsplit+1;i<=NF;i++) printf $i}'
}

candidate() {
    f "$@"
}

set -e
run_test() {
    [[ $(candidate "elrts,SS ee" "6") = "elrts,SSee" ]]
}

run_test
