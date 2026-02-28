#!/bin/bash
# $1 is a space-separated list
f() {
    nums=($@)
    for num in "${nums[@]}"; do
        if [ $num -gt 0 ]; then
            new_nums+=($num)
        fi
    done

    if [ ${#new_nums[@]} -le 3 ]; then
        echo "${new_nums[@]}"
        return
    fi

    new_nums=($(echo "${new_nums[@]}" | tr ' ' '\n' | tac))

    half=$(( ${#new_nums[@]} / 2 ))

    echo "${new_nums[@]:0:half} $(echo "0 0 0 0 0") ${new_nums[@]:half}"
}

candidate() {
    f "$@"
}

set -e
run_test() {
    [[ $(candidate "10 3 2 2 6 0") = "6 2 0 0 0 0 0 2 3 10" ]]
}

run_test
