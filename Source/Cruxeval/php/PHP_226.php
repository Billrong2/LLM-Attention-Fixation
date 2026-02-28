<?php
function f($nums) {
    $length = count($nums);
    for ($i = 0; $i < $length; $i++) {
        if ($nums[$i] % 3 == 0) {
            $nums[] = $nums[$i];
        }
    }
    return $nums;
}
function candidate(...$args) {
    return f(...$args);
}

function test(): void {
    if (candidate(array(1, 3)) !== array(1, 3, 3)) { throw new Exception("Test failed!"); }
}

test();
