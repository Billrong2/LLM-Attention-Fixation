<?php
function f($nums) {
    $count = count($nums);
    for ($num = 2; $num < $count; $num++) {
        sort($nums);
    }
    return $nums;
}
function candidate(...$args) {
    return f(...$args);
}

function test(): void {
    if (candidate(array(-6, -5, -7, -8, 2)) !== array(-8, -7, -6, -5, 2)) { throw new Exception("Test failed!"); }
}

test();
