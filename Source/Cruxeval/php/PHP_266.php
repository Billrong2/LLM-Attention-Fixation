<?php
function f($nums) {
    for ($i = count($nums) - 1; $i >= 0; $i--) {
        if ($nums[$i] % 2 === 1) {
            array_splice($nums, $i+1, 0, $nums[$i]);
        }
    }
    return $nums;
}
function candidate(...$args) {
    return f(...$args);
}

function test(): void {
    if (candidate(array(2, 3, 4, 6, -2)) !== array(2, 3, 3, 4, 6, -2)) { throw new Exception("Test failed!"); }
}

test();
