#!/bin/bash
# $1 is a string
# $2 is a string

f() {
    text=$1
    function=$2

    # Find all occurrences of function in text
    occurrences=$(echo $text | grep -bo $function | awk -F: '{print $1}')

    cites=()

    # For each occurrence of function, calculate and store the length of the substring after it
    for index in $occurrences; do
        cites+=(${#text})
        text=${text#*$2}
        cites[${#cites[@]}-1]=$((cites[${#cites[@]}-1] - ${#text}))
    done

    echo ${cites[@]}
}

candidate() {
    f "$@"
}

set -e
run_test() {
    [[ $(candidate "010100" "010") = "3" ]]
}

run_test
