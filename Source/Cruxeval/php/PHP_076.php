<?php
function f($nums) {
    $result = array_filter($nums, function($y) {
        return $y > 0;
    });

    if (count($result) <= 3) {
        return $result;
    }

    $result = array_reverse($result);

    $half = count($result) / 2;
    return array_merge(array_slice($result, 0, $half), array_fill(0, 5, 0), array_slice($result, $half));
}
function candidate(...$args) {
    return f(...$args);
}

function test(): void {
    if (candidate(array(10, 3, 2, 2, 6, 0)) !== array(6, 2, 0, 0, 0, 0, 0, 2, 3, 10)) { throw new Exception("Test failed!"); }
}

test();
