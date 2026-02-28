#!/bin/bash
# $1 is a string
f() {
    ls=$1
    for (( i=0; i<${#ls}; i++ )); do
        letter=${ls:$i:1}
        [[ ${letter,,} == ${letter} ]] && ls=${ls/$letter/}
    done
    echo $ls
}

candidate() {
    f "$@"
}

set -e
run_test() {
    [[ $(candidate "XYZ LittleRedRidingHood LiTTleBIGGeXEiT fault") = "XYZLtRRdnHodLTTBIGGeXET fult" ]]
}

run_test
