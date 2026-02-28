#!/bin/bash
# $1 is a string
f() {
    read -a arr <<< $1
    result=()
    for item in "${arr[@]}"
    do
        if [[ $item == *day ]]; then
            item+="y"
        else
            item+="day"
        fi
        result+=($item)
    done
    echo "${result[@]}"
}

candidate() {
    f "$@"
}

set -e
run_test() {
    [[ $(candidate "nwv mef ofme bdryl") = "nwvday mefday ofmeday bdrylday" ]]
}

run_test
