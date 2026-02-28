#!/bin/bash
# $1 is a space-separated list
f() {
    names=($1)
    if [ ${#names[@]} -eq 0 ]; then
        echo ""
    else
        smallest=${names[0]}
        for name in "${names[@]:1}"; do
            if [[ $name < $smallest ]]; then
                smallest=$name
            fi
        done
        names=("${names[@]/$smallest}")
        echo -n $smallest
    fi
}

candidate() {
    f "$@"
}

set -e
run_test() {
    [[ $(candidate "") = "" ]]
}

run_test
