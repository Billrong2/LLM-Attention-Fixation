#!/bin/bash
# $1 is a string
# $2 is a string
# $3 is an integer
f() {
    text=$1
    substr=$2
    occ=$3
    n=0
    while true; do
        i=$(expr index "$text" "$substr")
        if [ $i -eq 0 ]; then
            break
        elif [ $n -eq $occ ]; then
            echo $(expr length "$text") - $(expr length "${text##*"$substr"}") - 1
            return
        else
            n=$((n + 1))
            text=${text%$substr*}
        fi
    done
    echo -1
}

candidate() {
    f "$@"
}

set -e
run_test() {
    [[ $(candidate "zjegiymjc" "j" "2") = "-1" ]]
}

run_test
