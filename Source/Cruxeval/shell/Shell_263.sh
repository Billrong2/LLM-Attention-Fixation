#!/bin/bash
# $1 is a space-separated list
# $2 is a newline-separated, space-separated list
f() {
    local base=($1)
    local delta=($2)

    for ((j=0; j<${#delta[@]}; j++)); do
        for ((i=0; i<${#base[@]}; i++)); do
            if [ "${base[i]}" = "${delta[j]%% *}" ]; then
                if [ "${delta[j]##* }" != "${base[i]}" ]; then
                    base[i]=${delta[j]##* }
                else
                    echo "AssertionError: ${delta[j]##* } must be different from ${base[i]}" >&2
                    return 1
                fi
            fi
        done
    done

    echo "${base[@]}"
}

candidate() {
    f "$@"
}

set -e
run_test() {
    [[ $(candidate "gloss banana barn lawn" "") = "gloss banana barn lawn" ]]
}

run_test
