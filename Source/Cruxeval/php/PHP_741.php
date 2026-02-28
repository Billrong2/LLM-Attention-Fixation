<?php
function f($nums, $p) {
    $prev_p = $p - 1;
    if ($prev_p < 0) {
        $prev_p = count($nums) - 1;
    }
    return $nums[$prev_p];
}
function candidate(...$args) {
    return f(...$args);
}

function test(): void {
    if (candidate(array(6, 8, 2, 5, 3, 1, 9, 7), 6) !== 1) { throw new Exception("Test failed!"); }
}

test();
