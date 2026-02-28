<?php
function f($num1, $num2, $num3) {
    $nums = array($num1, $num2, $num3);
    sort($nums);
    return $nums[0] . ',' . $nums[1] . ',' . $nums[2];
}
function candidate(...$args) {
    return f(...$args);
}

function test(): void {
    if (candidate(6, 8, 8) !== "6,8,8") { throw new Exception("Test failed!"); }
}

test();
