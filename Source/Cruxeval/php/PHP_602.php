<?php
function f($nums, $target) {
    $cnt = array_count_values($nums)[$target] ?? 0;
    return $cnt * 2;
}
function candidate(...$args) {
    return f(...$args);
}

function test(): void {
    if (candidate(array(1, 1), 1) !== 4) { throw new Exception("Test failed!"); }
}

test();
