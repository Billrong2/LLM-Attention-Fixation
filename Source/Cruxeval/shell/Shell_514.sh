#!/bin/bash
# $1 is a string
f() {
    text=$1
    for item in $text; do
        text=$(echo $text | sed "s/-$item/ /g" | sed "s/$item-/ /g")
    done
    echo $text | sed 's/^-//; s/-$//'
}

candidate() {
    f "$@"
}

set -e
run_test() {
    [[ $(candidate "-stew---corn-and-beans-in soup-.-") = "stew---corn-and-beans-in soup-." ]]
}

run_test
