<?php
function f($nums) {
    $nums = array_reverse($nums);
    return implode('', array_map('strval', $nums));
}
function candidate(...$args) {
    return f(...$args);
}

function test(): void {
    if (candidate(array(-1, 9, 3, 1, -2)) !== "-2139-1") { throw new Exception("Test failed!"); }
}

test();
