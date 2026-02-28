<?php
function f($numbers, $elem, $idx) {
    array_splice($numbers, $idx, 0, $elem);
    return $numbers;
}
function candidate(...$args) {
    return f(...$args);
}

function test(): void {
    if (candidate(array(1, 2, 3), 8, 5) !== array(1, 2, 3, 8)) { throw new Exception("Test failed!"); }
}

test();
