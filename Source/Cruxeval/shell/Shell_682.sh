#!/bin/bash
# $1 is a string
# $2 is an integer
# $3 is an integer
f() {
    text=$1
    length=$2
    index=$3
    ls=($(echo $text | awk -v i=$index '{n=split($0,a," "); for(j=n-i+1; j<=n; j++) printf a[j]" ";}'))
    result=""
    for l in "${ls[@]}"; do
        result="$result$(echo $l | cut -c 1-$length)_"
    done
    echo ${result%_}
}

candidate() {
    f "$@"
}

set -e
run_test() {
    [[ $(candidate "hypernimovichyp" "2" "2") = "hy" ]]
}

run_test
