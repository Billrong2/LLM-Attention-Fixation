<?php
function f($nums, $target) {
    if (count(array_keys($nums, 0))) {
        return 0;
    } elseif (count(array_keys($nums, $target)) < 3) {
        return 1;
    } else {
        return array_search($target, $nums);
    }
}
function candidate(...$args) {
    return f(...$args);
}

function test(): void {
    if (candidate(array(1, 1, 1, 2), 3) !== 1) { throw new Exception("Test failed!"); }
}

test();
