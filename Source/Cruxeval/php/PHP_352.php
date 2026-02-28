<?php
function f($nums) {
    return $nums[intdiv(count($nums), 2)];
}
function candidate(...$args) {
    return f(...$args);
}

function test(): void {
    if (candidate(array(-1, -3, -5, -7, 0)) !== -5) { throw new Exception("Test failed!"); }
}

test();
