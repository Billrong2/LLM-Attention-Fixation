<?php
function f($nums, $start, $k) {
    array_splice($nums, $start, $k, array_reverse(array_slice($nums, $start, $k)));
    return $nums;
}
function candidate(...$args) {
    return f(...$args);
}

function test(): void {
    if (candidate(array(1, 2, 3, 4, 5, 6), 4, 2) !== array(1, 2, 3, 4, 6, 5)) { throw new Exception("Test failed!"); }
}

test();
