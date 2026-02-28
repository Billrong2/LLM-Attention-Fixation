<?php
function f($nums, $pos) {
    $s = array_slice($nums, 0);
    if ($pos % 2) {
        $s = array_slice($nums, 0, -1);
    }
    array_reverse($s);
    return $nums;
}
function candidate(...$args) {
    return f(...$args);
}

function test(): void {
    if (candidate(array(6, 1), 3) !== array(6, 1)) { throw new Exception("Test failed!"); }
}

test();
