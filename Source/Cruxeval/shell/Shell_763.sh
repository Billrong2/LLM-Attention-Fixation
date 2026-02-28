#!/bin/bash
# $1 is a string
# $2 is a string
# $3 is a string
f() {
    values="$1"
    text="$2"
    markers="$3"

    for (( i=${#values}-1; i>=0; i-- )); do
        text=${text%"${values:$i:1}"}
    done

    for (( i=${#markers}-1; i>=0; i-- )); do
        text=${text%"${markers:$i:1}"}
    done

    echo "$text"
}

candidate() {
    f "$@"
}

set -e
run_test() {
    [[ $(candidate "2Pn" "yCxpg2C2Pny2" "") = "yCxpg2C2Pny" ]]
}

run_test
