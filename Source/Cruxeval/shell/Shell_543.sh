#!/bin/bash
# $1 is a string
f() {
    modified=$(echo $1 | sed -e 's/\. / , /g' -e 's/&#33; /! /g' -e 's/\. /? /g' -e 's/\. /\. /g')
    first_char=$(echo $modified | cut -c1 | tr '[:lower:]' '[:upper:]')
    rest_chars=$(echo $modified | cut -c2-)
    echo $first_char$rest_chars
}

candidate() {
    f "$@"
}

set -e
run_test() {
    [[ $(candidate ".,,,,,. منبت") = ".,,,,, , منبت" ]]
}

run_test
