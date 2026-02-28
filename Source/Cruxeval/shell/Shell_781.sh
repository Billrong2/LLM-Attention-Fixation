#!/bin/bash
# $1 is a string
# $2 is a string
f() {
    s=$1
    ch=$2
    if [[ $s != *$ch* ]]; then
        echo ''
        return
    fi

    s=$(echo $s | awk -F"$ch" '{print $3}' | rev)
    for ((i=0; i<${#s}; i++)); do
        s=$(echo $s | awk -F"$ch" '{print $3}' | rev)
    done

    echo $s
}

candidate() {
    f "$@"
}

set -e
run_test() {
    [[ $(candidate "shivajimonto6" "6") = "" ]]
}

run_test
