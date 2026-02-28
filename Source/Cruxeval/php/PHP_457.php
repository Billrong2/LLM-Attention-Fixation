<?php
function f($nums) {
    $count = range(0, count($nums) - 1);
    while (count($nums) > 0) {
        array_pop($nums);
        if (count($count) > 0) {
            array_shift($count);
        }
    }
    return $nums;
}
function candidate(...$args) {
    return f(...$args);
}

function test(): void {
    if (candidate(array(3, 1, 7, 5, 6)) !== array()) { throw new Exception("Test failed!"); }
}

test();
