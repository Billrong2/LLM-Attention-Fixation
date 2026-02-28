#!/bin/bash
# $1 is a string
# $2 is a string
f() {
    s1=$1
    s2=$2
    res=()
    i=$((${#s1} - ${#s2}))
    while [ $i -ge 0 ]
    do
        if [ "${s1:$i:${#s2}}" = "$s2" ]; then
            res+=($((i+ ${#s2} - 1)))
        fi
        i=$((i - 1))
    done
    echo "${res[@]}"
}

candidate() {
    f "$@"
}

set -e
run_test() {
    [[ $(candidate "abcdefghabc" "abc") = "10 2" ]]
}

run_test
