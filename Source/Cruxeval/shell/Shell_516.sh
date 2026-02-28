#!/bin/bash
# $1 is a space-separated list
# $2 is a string
f() {
    strings=($1)
    substr=$2
    for s in "${strings[@]}"; do
        if [[ $s == $substr* ]]; then
            list+=($s)
        fi
    done
    sorted_list=($(for s in "${list[@]}"; do echo "$s"; done | awk '{ print length, $0 }' | sort -n | awk '{ $1=""; print $0 }'))
    echo "${sorted_list[@]}"
}

candidate() {
    f "$@"
}

set -e
run_test() {
    [[ $(candidate "condor eyes gay isa" "d") = "" ]]
}

run_test
