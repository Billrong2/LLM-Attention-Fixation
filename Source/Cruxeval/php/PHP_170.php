<?php
function f($nums, $number) {
    return count(array_keys($nums, $number));
}
function candidate(...$args) {
    return f(...$args);
}

function test(): void {
    if (candidate(array(12, 0, 13, 4, 12), 12) !== 2) { throw new Exception("Test failed!"); }
}

test();
