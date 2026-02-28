<?php
function f($nums) {
    $asc = $nums;
    $desc = [];
    $temp = array_reverse($asc);
    $desc = array_slice($temp, 0, count($temp) / 2);
    return array_merge($desc, $asc, $desc);
}
function candidate(...$args) {
    return f(...$args);
}

function test(): void {
    if (candidate(array()) !== array()) { throw new Exception("Test failed!"); }
}

test();
