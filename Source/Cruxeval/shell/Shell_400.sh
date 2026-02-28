#!/bin/bash
# $1 is a string
f() {
    IFS=' ' read -ra STRINGS <<< "$1"
    RESULT=''
    for STR in "${STRINGS[@]}"; do
        if [[ $STR == *['!'-'~']* ]]; then
            RESULT+="$STR, "
        fi
    done
    echo "${RESULT%, }"
}

candidate() {
    f "$@"
}

set -e
run_test() {
    [[ $(candidate "I am hungry\! eat food.") = "I, am, hungry\!, eat, food." ]]
}

run_test
