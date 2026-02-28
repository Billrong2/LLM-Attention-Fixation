#!/bin/bash
# $1 is a string
# $2 is a string
f() {
    # if suffix is empty, return true
    if [[ -z "$2" ]]; then
        echo true
    else
        # check if text ends with suffix
        if [[ "$1" == *"$2" ]]; then
            echo true
        else
            echo false
        fi
    fi
}

candidate() {
    f "$@"
}

set -e
run_test() {
    [[ $(candidate "uMeGndkGh" "kG") = "false" ]]
}

run_test
