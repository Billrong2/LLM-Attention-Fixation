<?php
function f($r, $w) {
    $a = [];
    if ($r[0] == $w[0] && $w[strlen($w) - 1] == $r[strlen($r) - 1]) {
        $a[] = $r;
        $a[] = $w;
    } else {
        $a[] = $w;
        $a[] = $r;
    }
    return $a;
}
function candidate(...$args) {
    return f(...$args);
}

function test(): void {
    if (candidate("ab", "xy") !== array("xy", "ab")) { throw new Exception("Test failed!"); }
}

test();
