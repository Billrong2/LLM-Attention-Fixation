#!/bin/bash
# $1 is a string
# $2 is a string
f() {
    full=$1
    part=$2

    length=${#part}
    count=0
    while [[ $full == *"$part"* ]]; do
        full=${full#*"$part"}
        ((count++))
    done
    echo $count
}

candidate() {
    f "$@"
}

set -e
run_test() {
    [[ $(candidate "hrsiajiajieihruejfhbrisvlmmy" "hr") = "2" ]]
}

run_test
