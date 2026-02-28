#!/bin/bash
# $1 is a string
# $2 is a string
f() {
    text=$1
    speaker=$2

    while [[ "$text" == "$speaker"* ]]; do
        text="${text:${#speaker}}"
    done

    echo "$text"
}

candidate() {
    f "$@"
}

set -e
run_test() {
    [[ $(candidate "[CHARRUNNERS]Do you know who the other was? [NEGMENDS]" "[CHARRUNNERS]") = "Do you know who the other was? [NEGMENDS]" ]]
}

run_test
