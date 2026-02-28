#!/bin/bash
# $1 is a string
# $2 is a string
f() {
    if [ -z "$2" ]; then
        return 1
    fi

    if [[ $2 == "["* ]]; then
        IFS=', ' read -ra prefixes <<< "$2"
        for pref in "${prefixes[@]}"; do
            if [[ $1 == $pref* ]]; then
                echo "true"
            else
                echo "false"
            fi
        done
    else
        if [[ $1 == $2* ]]; then
            echo "true"
        else
            echo "false"
        fi
    fi
}

candidate() {
    f "$@"
}

set -e
run_test() {
    [[ $(candidate "Hello World" "W") = "false" ]]
}

run_test
