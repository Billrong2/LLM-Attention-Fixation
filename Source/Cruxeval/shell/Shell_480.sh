#!/bin/bash
# $1 is a string
# $2 is a string
# $3 is a string
f() {
    if [ -z "$1" ]; then
        echo $1
        return
    fi

    IFS=$2 read -ra ls <<< "$1"
    for index in "${!ls[@]}"; do
        item=${ls[index]}
        if [[ $item == *"$2"* ]]; then
            ls[index]=${item/$2/$3}
        fi
    done

    echo "${ls[*]}"
}

candidate() {
    f "$@"
}

set -e
run_test() {
    [[ $(candidate "" "mi" "siast") = "" ]]
}

run_test
