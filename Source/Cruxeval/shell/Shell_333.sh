#!/bin/bash
# $1 is a space-separated list
# $2 is a space-separated list
f() {
    places=($1)
    lazy=($2)

    IFS=$'\n' sorted=($(sort <<<"${places[*]}"))
    unset IFS

    for l in ${lazy[@]}; do
        for i in ${!sorted[@]}; do
            if [[ ${sorted[i]} -eq $l ]]; then
                unset 'sorted[i]'
            fi
        done
    done

    if [[ ${#sorted[@]} -eq 1 ]]; then
        echo 1
        return
    fi

    for ((i=0; i<${#sorted[@]}; i++)); do
        current=${sorted[i]}
        next=$((current + 1))
        if ! [[ " ${sorted[*]} " =~ " $next " ]]; then
            echo $((i + 1))
            return
        fi
    done

    echo $((i + 1))
}

candidate() {
    f "$@"
}

set -e
run_test() {
    [[ $(candidate "375 564 857 90 728 92" "728") = "1" ]]
}

run_test
