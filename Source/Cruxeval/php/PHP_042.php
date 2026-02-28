<?php
function f(&$nums) {
    $nums = [];
    foreach ($nums as &$num) {
        $num *= 2;
        $nums[] = $num;
    }
    return $nums;
}
function candidate(...$args) {
    return f(...$args);
}

function test(): void {
    if (candidate(array(4, 3, 2, 1, 2, -1, 4, 2)) !== array()) { throw new Exception("Test failed!"); }
}

test();
