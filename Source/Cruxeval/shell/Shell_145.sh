#!/bin/bash
# $1 is a floating point
# $2 is a string
f() {
    price=$1
    product=$2
    inventory=('olives' 'key' 'orange')

    if [[ ! " ${inventory[@]} " =~ " ${product} " ]]; then
        echo $price
    else
        price=$(echo "scale=2; $price * 0.85" | bc)
        inventory=("${inventory[@]/$product}")
        echo $price
    fi
}

candidate() {
    f "$@"
}

set -e
run_test() {
    [[ $(candidate "8.5" "grapes") = "8.5" ]]
}

run_test
