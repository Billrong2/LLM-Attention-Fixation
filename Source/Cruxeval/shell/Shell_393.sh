#!/bin/bash
# $1 is a string
f() {
    ls=$(echo $1 | rev)
    text2=""
    for i in $(seq $((${#ls} - 3)) -3 1); do
        text2+=$(echo ${ls:$i:3} | sed 's/./&---/g' | sed 's/---$//')
        text2+="---"
    done
    echo ${text2::-3}
}

candidate() {
    f "$@"
}

set -e
run_test() {
    [[ $(candidate "scala") = "a---c---s" ]]
}

run_test
