<?php
function f($nums, $n) {
    $pos = count($nums) - 1;
    for ($i = -count($nums); $i < 0; $i++) {
        array_splice($nums, $pos, 0, $nums[$i]);
    }
    return $nums;
}
function candidate(...$args) {
    return f(...$args);
}

function test(): void {
    if (candidate(array(), 14) !== array()) { throw new Exception("Test failed!"); }
}

test();
