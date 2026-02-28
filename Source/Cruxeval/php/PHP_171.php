<?php
function f($nums) {
    $count = intval(count($nums) / 2);
    for ($i = 0; $i < $count; $i++) {
        array_shift($nums);
    }
    return $nums;
}
function candidate(...$args) {
    return f(...$args);
}

function test(): void {
    if (candidate(array(3, 4, 1, 2, 3)) !== array(1, 2, 3)) { throw new Exception("Test failed!"); }
}

test();
