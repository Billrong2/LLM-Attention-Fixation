#!/bin/bash
# $1 is a string
# $2 is a string
f() {
    text=$1
    sub=$2
    index=()
    starting=0
    while [ $starting -ne -1 ]; do
        starting=$(echo $text | awk "{print index(\$0, \"$sub\", $starting)}")
        if [ $starting -ne -1 ]; then
            index+=($starting)
            starting=$((starting + ${#sub}))
        fi
    done
    echo "${index[@]}"
}

candidate() {
    f "$@"
}

set -e
run_test() {
    [[ $(candidate "egmdartoa" "good") = "" ]]
}

run_test
