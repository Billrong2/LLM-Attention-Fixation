#!/bin/bash
# $1 is a string
f() {
    local s=$1
    local count=$(( ${#s} - 1 ))
    local reverse_s=$(echo $s | rev)
    
    while [ $count -gt 0 ] && [ $(echo $reverse_s | cut -c 2- | grep -o 'sea' | wc -l) -eq 0 ]; do
        count=$(( count - 1 ))
        reverse_s=$(echo $reverse_s | cut -c 1-$count)
    done

    echo ${reverse_s:$count}
}

candidate() {
    f "$@"
}

set -e
run_test() {
    [[ $(candidate "s a a b s d s a a s a a") = "" ]]
}

run_test
