<?php
function f($lst, $i, $n) {
    array_splice($lst, $i, 0, $n);
    return $lst;
}
function candidate(...$args) {
    return f(...$args);
}

function test(): void {
    if (candidate(array(44, 34, 23, 82, 24, 11, 63, 99), 4, 15) !== array(44, 34, 23, 82, 15, 24, 11, 63, 99)) { throw new Exception("Test failed!"); }
}

test();
