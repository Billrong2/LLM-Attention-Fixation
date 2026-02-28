<?php
function f($nums) {
    $nums = array_reverse($nums);
    return $nums;
}
function candidate(...$args) {
    return f(...$args);
}

function test(): void {
    if (candidate(array(-6, -2, 1, -3, 0, 1)) !== array(1, 0, -3, 1, -2, -6)) { throw new Exception("Test failed!"); }
}

test();
