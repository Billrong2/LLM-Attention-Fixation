<?php
function f($nums) {
    $count = count($nums);
    while (count($nums) > intval($count/2)) {
        $nums = [];
    }
    return $nums;
}
function candidate(...$args) {
    return f(...$args);
}

function test(): void {
    if (candidate(array(2, 1, 2, 3, 1, 6, 3, 8)) !== array()) { throw new Exception("Test failed!"); }
}

test();
