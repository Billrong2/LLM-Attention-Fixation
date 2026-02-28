<?php
function f($nums) {
    for ($i = 0; $i < count($nums) - 1; $i++) {
        array_reverse($nums);
    }
    return $nums;
}
function candidate(...$args) {
    return f(...$args);
}

function test(): void {
    if (candidate(array(1, -9, 7, 2, 6, -3, 3)) !== array(1, -9, 7, 2, 6, -3, 3)) { throw new Exception("Test failed!"); }
}

test();
