<?php
function f($a, $split_on) {
    $t = explode(" ", $a);
    $a = [];
    foreach($t as $i) {
        foreach(str_split($i) as $j) {
            $a[] = $j;
        }
    }
    if (in_array($split_on, $a)) {
        return true;
    } else {
        return false;
    }
}
function candidate(...$args) {
    return f(...$args);
}

function test(): void {
    if (candidate("booty boot-boot bootclass", "k") !== false) { throw new Exception("Test failed!"); }
}

test();
