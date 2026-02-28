<?php
function f($s) {
    $nums = preg_replace('/\D/', '', $s);
    if ($nums === '') {
        return 'none';
    }
    $numsArr = explode(',', $nums);
    $numsArr = array_map('intval', $numsArr);
    $m = max($numsArr);
    return strval($m);
}
function candidate(...$args) {
    return f(...$args);
}

function test(): void {
    if (candidate("01,001") !== "1001") { throw new Exception("Test failed!"); }
}

test();
