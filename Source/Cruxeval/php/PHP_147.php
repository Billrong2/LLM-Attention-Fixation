<?php
function f($nums) {
    $middle = count($nums) / 2;
    return array_merge(array_slice($nums, $middle), array_slice($nums, 0, $middle));
}
function candidate(...$args) {
    return f(...$args);
}

function test(): void {
    if (candidate(array(1, 1, 1)) !== array(1, 1, 1)) { throw new Exception("Test failed!"); }
}

test();
