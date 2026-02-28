#!/bin/bash
# $1 is a space-separated list
f() {
    years=($1)
    a10=0
    a90=0
    for year in "${years[@]}"; do
        if [ $year -le 1900 ]; then
            ((a10++))
        elif [ $year -gt 1910 ]; then
            ((a90++))
        fi
    done
    
    if [ $a10 -gt 3 ]; then
        echo 3
    elif [ $a90 -gt 3 ]; then
        echo 1
    else
        echo 2
    fi
}

candidate() {
    f "$@"
}

set -e
run_test() {
    [[ $(candidate "1872 1995 1945") = "2" ]]
}

run_test
