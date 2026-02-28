<?php
function f($seq, $v) {
    $a = [];
    foreach ($seq as $i) {
        if (substr($i, -strlen($v)) === $v) {
            $a[] = $i . $i;
        }
    }
    return $a;
}
function candidate(...$args) {
    return f(...$args);
}

function test(): void {
    if (candidate(array("oH", "ee", "mb", "deft", "n", "zz", "f", "abA"), "zz") !== array("zzzz")) { throw new Exception("Test failed!"); }
}

test();
