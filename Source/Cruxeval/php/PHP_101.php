<?php
function f($array, $i_num, $elem) {
    array_splice($array, $i_num, 0, $elem);
    return $array;
}
function candidate(...$args) {
    return f(...$args);
}

function test(): void {
    if (candidate(array(-4, 1, 0), 1, 4) !== array(-4, 4, 1, 0)) { throw new Exception("Test failed!"); }
}

test();
