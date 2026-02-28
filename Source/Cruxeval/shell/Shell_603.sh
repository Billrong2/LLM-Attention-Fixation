#!/bin/bash
# $1 is a string
f() {
    words=($(echo $1 | tr "." "\n"))
    oscillating=true

    for word in "${words[@]}"
    do
        if ! [[ $word =~ ^[0-9]+$ ]]
        then
            oscillating=false
            break
        fi
    done

    if $oscillating
    then
        echo "oscillating"
    else
        echo "not oscillating"
    fi
}

candidate() {
    f "$@"
}

set -e
run_test() {
    [[ $(candidate "not numbers") = "not oscillating" ]]
}

run_test
