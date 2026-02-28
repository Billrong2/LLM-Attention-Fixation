<?php
function f($array) {
    $l = count($array);
    if ($l % 2 == 0) {
        $array = [];
    } else {
        $array = array_reverse($array);
    }
    return $array;
}
function candidate(...$args) {
    return f(...$args);
}

function test(): void {
    if (candidate(array()) !== array()) { throw new Exception("Test failed!"); }
}

test();
