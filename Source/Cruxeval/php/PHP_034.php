<?php
function f($nums, $odd1, $odd2) {
    while (in_array($odd1, $nums)) {
        $key = array_search($odd1, $nums);
        unset($nums[$key]);
    }
    while (in_array($odd2, $nums)) {
        $key = array_search($odd2, $nums);
        unset($nums[$key]);
    }
    return array_values($nums);
}
function candidate(...$args) {
    return f(...$args);
}

function test(): void {
    if (candidate(array(1, 2, 3, 7, 7, 6, 8, 4, 1, 2, 3, 5, 1, 3, 21, 1, 3), 3, 1) !== array(2, 7, 7, 6, 8, 4, 2, 5, 21)) { throw new Exception("Test failed!"); }
}

test();
