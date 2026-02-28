<?php
function f($nums) {
    $length = count($nums);
    for ($i = 0; $i < $length; $i++) {
        array_splice($nums, $i, 0, $nums[$i] ** 2);
    }
    return $nums;
}
function candidate(...$args) {
    return f(...$args);
}

function test(): void {
    if (candidate(array(1, 2, 4)) !== array(1, 1, 1, 1, 2, 4)) { throw new Exception("Test failed!"); }
}

test();
