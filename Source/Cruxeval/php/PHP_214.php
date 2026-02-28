<?php
function f($sample) {
    $i = -1;
    while (($pos = strpos($sample, '/', $i+1)) !== false) {
        $i = $pos;
    }
    return strrpos(substr($sample, 0, $i), '/');
}
function candidate(...$args) {
    return f(...$args);
}

function test(): void {
    if (candidate("present/here/car%2Fwe") !== 7) { throw new Exception("Test failed!"); }
}

test();
