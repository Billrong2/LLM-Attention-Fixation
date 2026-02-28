<?php
function f($array, $n) {
    return array_slice($array, $n);
}
function candidate(...$args) {
    return f(...$args);
}

function test(): void {
    if (candidate(array(0, 0, 1, 2, 2, 2, 2), 4) !== array(2, 2, 2)) { throw new Exception("Test failed!"); }
}

test();
