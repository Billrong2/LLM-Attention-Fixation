<?php
function f($nums) {
    $m = max($nums);
    for ($i = 0; $i < $m; $i++) {
        $nums = array_reverse($nums);
    }
    return $nums;
}
function candidate(...$args) {
    return f(...$args);
}

function test(): void {
    if (candidate(array(43, 0, 4, 77, 5, 2, 0, 9, 77)) !== array(77, 9, 0, 2, 5, 77, 4, 0, 43)) { throw new Exception("Test failed!"); }
}

test();
