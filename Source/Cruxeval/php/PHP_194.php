<?php
function f($matr, $insert_loc) {
    array_splice($matr, $insert_loc, 0, [[]]);
    return $matr;
}
function candidate(...$args) {
    return f(...$args);
}

function test(): void {
    if (candidate(array(array(5, 6, 2, 3), array(1, 9, 5, 6)), 0) !== array(array(), array(5, 6, 2, 3), array(1, 9, 5, 6))) { throw new Exception("Test failed!"); }
}

test();
