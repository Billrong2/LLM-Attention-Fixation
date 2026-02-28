#!/bin/bash
# $1 is a space-separated list
f() {
    local mylist=($1)
    local revl=("${mylist[@]}")
    local result="true"

    for i in ${!revl[@]}; do
        revl[$i]=${mylist[$(( ${#mylist[@]} - $i - 1 ))]}
    done

    IFS=$'\n'
    sorted=($(sort -nr <<<"${mylist[*]}")); unset IFS

    for i in ${!sorted[@]}; do
        if [[ "${sorted[$i]}" -ne "${revl[$i]}" ]]; then
            result="false"
            break
        fi
    done

    echo "$result"
    [ "$result" == "true" ]
}

candidate() {
    f "$@"
}

set -e
run_test() {
    [[ $(candidate "5 8") = "true" ]]
}

run_test
