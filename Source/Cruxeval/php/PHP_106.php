<?php
function f($nums) {
    $count = count($nums);
    for ($i = 0; $i < $count; $i++) {
        array_splice($nums, $i, 0, $nums[$i]*2);
    }
    return $nums;
}
function candidate(...$args) {
    return f(...$args);
}

function test(): void {
    if (candidate(array(2, 8, -2, 9, 3, 3)) !== array(4, 4, 4, 4, 4, 4, 2, 8, -2, 9, 3, 3)) { throw new Exception("Test failed!"); }
}

test();
