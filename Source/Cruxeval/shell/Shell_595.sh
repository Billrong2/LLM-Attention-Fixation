#!/bin/bash
# $1 is a string
# $2 is a string
f() {
    text=$1
    prefix=$2

    if [[ $text == $prefix* ]]; then
        text=${text#$prefix}
    fi

    text=$(echo $text | awk '{print toupper(substr($0,1,1)) tolower(substr($0,2))}')
    echo $text
}

candidate() {
    f "$@"
}

set -e
run_test() {
    [[ $(candidate "qdhstudentamxupuihbuztn" "jdm") = "Qdhstudentamxupuihbuztn" ]]
}

run_test
