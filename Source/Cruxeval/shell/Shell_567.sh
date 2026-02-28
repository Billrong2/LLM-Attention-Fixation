#!/bin/bash
# $1 is a string
# $2 is an integer
f() {
    ls=($1)
    out=()
    while (( ${#ls[@]} >= $2 )); do
        out=("${ls[@]:(- $2)}" "${out[@]}")
        ls=("${ls[@]:0:((${#ls[@]} - $2))}")
    done
    echo "${ls[@]}" $(IFS=_; echo "${out[*]}")
}

candidate() {
    f "$@"
}

set -e
run_test() {
    [[ $(candidate "one two three four five" "3") = "one two three_four_five" ]]
}

run_test
