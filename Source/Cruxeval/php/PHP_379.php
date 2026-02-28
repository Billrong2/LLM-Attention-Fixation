<?php
function f($nums) {
    for($i = count($nums) - 1; $i >= 0; $i -= 3) {
        if($nums[$i] == 0) {
            $nums = [];
            return false;
        }
    }
    return $nums;
}
function candidate(...$args) {
    return f(...$args);
}

function test(): void {
    if (candidate(array(0, 0, 1, 2, 1)) !== false) { throw new Exception("Test failed!"); }
}

test();
