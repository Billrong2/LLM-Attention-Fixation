<?php
function f($nums) {
    for ($i = 0; $i < count($nums); $i++) {
        if ($i % 2 === 0) {
            $nums[] = $nums[$i] * $nums[$i + 1];
        }
    }
    return $nums;
}
function candidate(...$args) {
    return f(...$args);
}

function test(): void {
    if (candidate(array()) !== array()) { throw new Exception("Test failed!"); }
}

test();
