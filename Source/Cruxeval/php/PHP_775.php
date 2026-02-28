<?php
function f($nums) {
    $count = count($nums);
    for ($i = 0; $i < intval($count / 2); $i++) {
        $temp = $nums[$i];
        $nums[$i] = $nums[$count-$i-1];
        $nums[$count-$i-1] = $temp;
    }
    return $nums;
}
function candidate(...$args) {
    return f(...$args);
}

function test(): void {
    if (candidate(array(2, 6, 1, 3, 1)) !== array(1, 3, 1, 6, 2)) { throw new Exception("Test failed!"); }
}

test();
