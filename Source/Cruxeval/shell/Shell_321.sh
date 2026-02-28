#!/bin/bash
# $1 is a two column CSV in key,value order
# $2 is a two column CSV in key,value order
f() {
    declare -A starting
    declare -A update

    IFS=',' read -r -a starting_keys_values <<< "$1"
    for i in "${!starting_keys_values[@]}"; do
        if (( $i % 2 == 0 )); then
            key="${starting_keys_values[$i]}"
            value="${starting_keys_values[$((i+1))]}"
            starting["$key"]="$value"
        fi
    done

    IFS=',' read -r -a update_keys_values <<< "$2"
    for i in "${!update_keys_values[@]}"; do
        if (( $i % 2 == 0 )); then
            key="${update_keys_values[$i]}"
            value="${update_keys_values[$((i+1))]}"
            
            if [[ -v starting[$key] ]]; then
                starting["$key"]=$(( ${starting["$key"]} + $value ))
            else
                starting["$key"]="$value"
            fi
        fi
    done

    for key in "${!starting[@]}"; do
        echo "$key,${starting[$key]}"
    done
}

candidate() {
    f "$@"
}

set -e
run_test() {
    [[ $(candidate "" "desciduous,2") = "desciduous,2" ]]
}

run_test
