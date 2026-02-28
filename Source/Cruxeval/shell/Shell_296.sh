#!/bin/bash
# $1 is a string
f() {
    echo ${1/http:\/\/www./}
}

candidate() {
    f "$@"
}

set -e
run_test() {
    [[ $(candidate "https://www.www.ekapusta.com/image/url") = "https://www.www.ekapusta.com/image/url" ]]
}

run_test
