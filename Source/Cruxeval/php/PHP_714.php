<?php
function f($array) {
    array_reverse($array);
    array_splice($array, 0);
    $array = array_fill(0, count($array), 'x');
    array_reverse($array);
    return $array;
}
function candidate(...$args) {
    return f(...$args);
}

function test(): void {
    if (candidate(array(3, -2, 0)) !== array()) { throw new Exception("Test failed!"); }
}

test();
