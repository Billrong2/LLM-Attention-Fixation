<?php
function f($nums) {
    $count = count($nums);
    for ($i = count($nums) - 1; $i >= 0; $i--) {
        array_splice($nums, $i, 0, array_shift($nums));
    }
    return $nums;
}
function candidate(...$args) {
    return f(...$args);
}

function test(): void {
    if (candidate(array(0, -5, -4)) !== array(-4, -5, 0)) { throw new Exception("Test failed!"); }
}

test();
