<?php
function f($nums) {
    $count = 1;
    for ($i = $count; $i < count($nums) - 1; $i += 2) {
        $nums[$i] = max($nums[$i], $nums[$count-1]);
        $count++;
    }
    return $nums;
}
function candidate(...$args) {
    return f(...$args);
}

function test(): void {
    if (candidate(array(1, 2, 3)) !== array(1, 2, 3)) { throw new Exception("Test failed!"); }
}

test();
