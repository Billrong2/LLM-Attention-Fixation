<?php
function f($array, $L) {
    if ($L <= 0) {
        return $array;
    }
    if (count($array) < $L) {
        $array = array_merge($array, f($array, $L - count($array)));
    }
    return $array;
}
function candidate(...$args) {
    return f(...$args);
}

function test(): void {
    if (candidate(array(1, 2, 3), 4) !== array(1, 2, 3, 1, 2, 3)) { throw new Exception("Test failed!"); }
}

test();
