#!/bin/bash
# $1 is a string
f() {
    new_name=''
    name=$(echo $1 | rev)
    for (( i=0; i<${#name}; i++ )); do
        n=${name:$i:1}
        if [[ $n != '.' ]] && [[ $(grep -o '\.' <<< $new_name | wc -l) -lt 2 ]]; then
            new_name=$n$new_name
        else
            break
        fi
    done
    echo $new_name
}

candidate() {
    f "$@"
}

set -e
run_test() {
    [[ $(candidate ".NET") = "NET" ]]
}

run_test
