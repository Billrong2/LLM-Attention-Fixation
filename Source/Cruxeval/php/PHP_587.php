<?php
function f($nums, $fill) {
    $ans = array_fill_keys($nums, $fill);
    return $ans;
}
function candidate(...$args) {
    return f(...$args);
}

function test(): void {
    if (candidate(array(0, 1, 1, 2), "abcca") !== array(0 => "abcca", 1 => "abcca", 2 => "abcca")) { throw new Exception("Test failed!"); }
}

test();
