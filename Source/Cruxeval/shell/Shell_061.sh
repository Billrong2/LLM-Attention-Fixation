#!/bin/bash
# $1 is a string
f() {
    texts=($1)
    if [[ ${#texts[@]} -gt 0 ]]; then
        xtexts=()
        for t in "${texts[@]}"; do
            if [[ $(echo "$t" | LC_ALL=C grep -P '^[ -~]+$') && ! ( "$t" == "nada" || "$t" == "0" ) ]]; then
                xtexts+=("$t")
            fi
        done
        if [[ ${#xtexts[@]} -gt 0 ]]; then
            max_len=0
            for t in "${xtexts[@]}"; do
                if [[ ${#t} -gt $max_len ]]; then
                    max_len=${#t}
                    longest=$t
                fi
            done
            echo $longest
        else
            echo 'nada'
        fi
    else
        echo 'nada'
    fi
}

candidate() {
    f "$@"
}

set -e
run_test() {
    [[ $(candidate "") = "nada" ]]
}

run_test
