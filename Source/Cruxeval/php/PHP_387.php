<?php
function f($nums, $pos, $value) {
    array_splice($nums, $pos, 0, $value);
    return $nums;
}
function candidate(...$args) {
    return f(...$args);
}

function test(): void {
    if (candidate(array(3, 1, 2), 2, 0) !== array(3, 1, 0, 2)) { throw new Exception("Test failed!"); }
}

test();
