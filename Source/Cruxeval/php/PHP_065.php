<?php
function f($nums, $index) {
    $result = $nums[$index] % 42 + $nums[$index] * 2;
    array_splice($nums, $index, 1);
    return $result;
}
function candidate(...$args) {
    return f(...$args);
}

function test(): void {
    if (candidate(array(3, 2, 0, 3, 7), 3) !== 9) { throw new Exception("Test failed!"); }
}

test();
