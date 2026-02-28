<?php
function f($nums, $i) {
    unset($nums[$i]);
    return array_values($nums);
}
function candidate(...$args) {
    return f(...$args);
}

function test(): void {
    if (candidate(array(35, 45, 3, 61, 39, 27, 47), 0) !== array(45, 3, 61, 39, 27, 47)) { throw new Exception("Test failed!"); }
}

test();
