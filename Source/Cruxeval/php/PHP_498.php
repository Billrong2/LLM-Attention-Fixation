<?php
function f($nums, $idx, $added) {
    array_splice($nums, $idx, 0, array($added));
    return $nums;
}
function candidate(...$args) {
    return f(...$args);
}

function test(): void {
    if (candidate(array(2, 2, 2, 3, 3), 2, 3) !== array(2, 2, 3, 2, 3, 3)) { throw new Exception("Test failed!"); }
}

test();
