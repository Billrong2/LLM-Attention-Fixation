#!/bin/bash
# $1 is a string
# $2 is an integer
f() {
    while IFS= read -r line; do
        a+=( "$(printf "%-${2}s" "$line")" )
    done <<< "$1"

    printf "%s\n" "${a[@]}"
}

candidate() {
    f "$@"
}

set -e
run_test() {
    [[ $(candidate "#[)[]>[^e>\n 8" "-5") = "#[)[]>[^e>\n 8" ]]
}

run_test
