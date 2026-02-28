#!/bin/bash
# $1 is a space-separated list
# $2 is a string
f() {
    IFS=' '
    read -r -a items <<< "$1"
    item="$2"
    while [[ ${items[-1]} == "$item" ]]
    do
        unset 'items[${#items[@]}-1]'
    done
    items+=("$item")
    echo ${#items[@]}
}

candidate() {
    f "$@"
}

set -e
run_test() {
    [[ $(candidate "bfreratrrbdbzagbretaredtroefcoiqrrneaosf" "n") = "2" ]]
}

run_test
