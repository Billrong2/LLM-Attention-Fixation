#!/bin/bash
# $1 is a string
# $2 is a string
f() {
    IFS=$2 read -ra array <<< "$1"
    reverse=""
    for ((i=${#array[@]}-1; i>=0; i--)); do
        reverse+="*${array[i]};"
    done
    echo ${reverse::-1}
}

candidate() {
    f "$@"
}

set -e
run_test() {
    [[ $(candidate "volume" "l") = "*ume;*vo" ]]
}

run_test
