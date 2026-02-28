<?php
function f($nums, $pop1, $pop2) {
    array_splice($nums, $pop1 - 1, 1);
    array_splice($nums, $pop2 - 1, 1);
    return $nums;
}
function candidate(...$args) {
    return f(...$args);
}

function test(): void {
    if (candidate(array(1, 5, 2, 3, 6), 2, 4) !== array(1, 2, 3)) { throw new Exception("Test failed!"); }
}

test();
