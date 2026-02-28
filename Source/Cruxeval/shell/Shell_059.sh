#!/bin/bash
# $1 is a string
f() {
    a=$(echo $1 | tr -d ' ')
    b=$a
    reversed=""
    for (( i=${#a}-1; i >= 0; i-- )); do
        reversed="$reversed${a:$i:1}"
    done
    for (( i=0; i<${#a}; i++ )); do
        c=${reversed:$i:1}
        if [ "$c" == " " ]; then
            b=$(echo $b | sed 's/.$//')
        else
            break
        fi
    done
    echo $b
}

candidate() {
    f "$@"
}

set -e
run_test() {
    [[ $(candidate "hi ") = "hi" ]]
}

run_test
