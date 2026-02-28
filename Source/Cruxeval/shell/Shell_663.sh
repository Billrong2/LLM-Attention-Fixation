#!/bin/bash
# $1 is a space-separated list
# $2 is a $Any
f() {
    local container=($1)
    local cron=$2
    local index=-1
    for (( i=0; i<${#container[@]}; i++ )); do
        if [ "${container[i]}" == "$cron" ]; then
            index=$i
            break
        fi
    done

    if [ $index -eq -1 ]; then
        echo $1
    else
        local pref=("${container[@]:0:index}")
        local suff=("${container[@]:index+1}")
        echo "${pref[@]}" "${suff[@]}"
    fi
}

candidate() {
    f "$@"
}

set -e
run_test() {
    [[ $(candidate "" "2") = "" ]]
}

run_test
