#!/bin/bash
# $1 is a floating point
f() {
    number=$(echo "$1" | sed 's/\./ /')
    integer_part=$(echo $number | awk '{print $1}')
    decimal_part=$(echo $number | awk '{print $2}')    

    if [ ! -z "$decimal_part" ]; then
        printf "%s.%s" $integer_part $(printf "%s" "$decimal_part" | awk '{printf "%-2s", $1}')
    else
        printf "%s.00" $integer_part
    fi
}

candidate() {
    f "$@"
}

set -e
run_test() {
    [[ $(candidate "3.121") = "3.121" ]]
}

run_test
