#!/bin/bash
# $1 is a string
# $2 is a string
f() {
    count=$(echo $1 | grep -o $2 | wc -l)
    base=$(printf "%0.s$2" $(seq 1 $((count + 1))))
    echo ${1%$base}
}

candidate() {
    f "$@"
}

set -e
run_test() {
    [[ $(candidate "mnmnj krupa...##\!@#\!@#\$\$@##" "@") = "mnmnj krupa...##\!@#\!@#\$\$@##" ]]
}

run_test
