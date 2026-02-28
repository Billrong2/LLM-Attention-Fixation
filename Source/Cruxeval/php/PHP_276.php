<?php
function f($a) {
    if (count($a) >= 2 && $a[0] > 0 && $a[1] > 0) {
        array_reverse($a);
        return $a;
    }

    array_push($a, 0);
    return $a;
}
function candidate(...$args) {
    return f(...$args);
}

function test(): void {
    if (candidate(array()) !== array(0)) { throw new Exception("Test failed!"); }
}

test();
