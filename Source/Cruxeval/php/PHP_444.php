<?php
function f($nums) {
    $count = count($nums);
    for ($i = $count-1; $i > 0; $i -= 2) {
        array_splice($nums, $i, 0, array_shift($nums) + array_shift($nums));
    }
    return $nums;
}
function candidate(...$args) {
    return f(...$args);
}

function test(): void {
    if (candidate(array(-5, 3, -2, -3, -1, 3, 5)) !== array(5, -2, 2, -5)) { throw new Exception("Test failed!"); }
}

test();
