<?php
function f($nums) {
    $a = -1;
    $b = array_slice($nums, 1);
    while ($a <= $b[0]) {
        $key = array_search($b[0], $nums);
        array_splice($nums, $key, 1);
        $a = 0;
        $b = array_slice($b, 1);
    }
    return $nums;
}
function candidate(...$args) {
    return f(...$args);
}

function test(): void {
    if (candidate(array(-1, 5, 3, -2, -6, 8, 8)) !== array(-1, -2, -6, 8, 8)) { throw new Exception("Test failed!"); }
}

test();
