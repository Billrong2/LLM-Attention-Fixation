<?php
function f($nums, $spot, $idx) {
    array_splice($nums, $spot, 0, $idx);
    return $nums;
}
function candidate(...$args) {
    return f(...$args);
}

function test(): void {
    if (candidate(array(1, 0, 1, 1), 0, 9) !== array(9, 1, 0, 1, 1)) { throw new Exception("Test failed!"); }
}

test();
