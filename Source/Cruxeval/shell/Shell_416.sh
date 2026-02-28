#!/bin/bash
# $1 is a string
# $2 is a string
# $3 is a string
f() {
    text=$1
    old=$2
    new=$3
    index=$(echo $text | grep -bo $old | head -n 1 | cut -d: -f1)
    while [ $index -gt 0 ]; do
        text=$(echo $text | sed "s/$old/$new/")
        index=$(echo $text | grep -bo $old | head -n 1 | cut -d: -f1)
    done
    echo $text
}

candidate() {
    f "$@"
}

set -e
run_test() {
    [[ $(candidate "jysrhfm ojwesf xgwwdyr dlrul ymba bpq" "j" "1") = "jysrhfm ojwesf xgwwdyr dlrul ymba bpq" ]]
}

run_test
