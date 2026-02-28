#!/bin/bash
# $1 is a string
f() {
    string=$1
    if [[ $string == *"e"* ]]; then
        strlen=${#string}
        for (( i=$strlen-1; i>=0; i-- )); do
            if [ ${string:$i:1} = "e" ]; then
                echo $i
                return
            fi
        done
    else
        echo "Nuk"
    fi
}

candidate() {
    f "$@"
}

set -e
run_test() {
    [[ $(candidate "eeuseeeoehasa") = "8" ]]
}

run_test
