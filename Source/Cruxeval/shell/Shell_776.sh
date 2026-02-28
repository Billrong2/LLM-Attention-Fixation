#!/bin/bash
# $1 is a two column CSV in key,value order
f() {
    local dictionary
    dictionary=$(echo "$1" | awk -F',' '{print $1,$2}')
    for row in $dictionary; do
        key=$(echo $row | cut -d' ' -f1)
        value=$(echo $row | cut -d' ' -f2)
        if [ $((key % 2)) -ne 0 ]; then
            dictionary=${dictionary//$key/}
            dictionary+='$'$key' '$value' '
        fi
    done
    echo $dictionary
}

candidate() {
    f "$@"
}

set -e
run_test() {
    [[ $(candidate "") = "" ]]
}

run_test
