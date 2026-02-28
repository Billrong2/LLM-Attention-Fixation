<?php
function f($array, $index, $value) {
    array_unshift($array, $index + 1);
    if ($value >= 1) {
        array_splice($array, $index, 0, $value);
    }
    return $array;
}
function candidate(...$args) {
    return f(...$args);
}

function test(): void {
    if (candidate(array(2), 0, 2) !== array(2, 1, 2)) { throw new Exception("Test failed!"); }
}

test();
