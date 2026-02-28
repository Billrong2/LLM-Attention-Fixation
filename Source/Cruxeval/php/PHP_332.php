<?php
function f($nums) {
    $count = count($nums);
    if ($count == 0) {
        $nums = array_fill(0, intval(array_pop($nums)), 0);
    } elseif ($count % 2 == 0) {
        $nums = [];
    } else {
        array_splice($nums, 0, $count/2);
    }
    return $nums;
}
function candidate(...$args) {
    return f(...$args);
}

function test(): void {
    if (candidate(array(-6, -2, 1, -3, 0, 1)) !== array()) { throw new Exception("Test failed!"); }
}

test();
