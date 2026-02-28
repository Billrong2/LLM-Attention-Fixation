<?php
function f($nums) {
    foreach (range(count($nums) - 1, 0, -1) as $i) {
        if ($nums[$i] % 2 == 0) {
            unset($nums[$i]);
        }
    }
    return array_values($nums);
}
function candidate(...$args) {
    return f(...$args);
}

function test(): void {
    if (candidate(array(5, 3, 3, 7)) !== array(5, 3, 3, 7)) { throw new Exception("Test failed!"); }
}

test();
