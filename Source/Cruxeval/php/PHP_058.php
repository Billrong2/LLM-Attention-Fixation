<?php
function f($nums) {
    $count = count($nums);
    foreach (range(0, $count - 1) as $i) {
        $nums[] = $nums[$i % 2];
    }
    return $nums;
}
function candidate(...$args) {
    return f(...$args);
}

function test(): void {
    if (candidate(array(-1, 0, 0, 1, 1)) !== array(-1, 0, 0, 1, 1, -1, 0, -1, 0, -1)) { throw new Exception("Test failed!"); }
}

test();
