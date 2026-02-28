<?php
function f($nums, $sort_count) {
    sort($nums);
    return array_slice($nums, 0, $sort_count);
}
function candidate(...$args) {
    return f(...$args);
}

function test(): void {
    if (candidate(array(1, 2, 2, 3, 4, 5), 1) !== array(1)) { throw new Exception("Test failed!"); }
}

test();
