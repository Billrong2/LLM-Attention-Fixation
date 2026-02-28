<?php
function f($array, $index) {
    if ($index < 0) {
        $index = count($array) + $index;
    }
    return $array[$index];
}
function candidate(...$args) {
    return f(...$args);
}

function test(): void {
    if (candidate(array(1), 0) !== 1) { throw new Exception("Test failed!"); }
}

test();
