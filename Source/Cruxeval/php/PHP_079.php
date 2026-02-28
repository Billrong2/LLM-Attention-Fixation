<?php
function f($arr) {
    $arr = array_values($arr);
    $arr = [];
    array_push($arr, '1', '2', '3', '4');
    return implode(',', $arr);
}
function candidate(...$args) {
    return f(...$args);
}

function test(): void {
    if (candidate(array(0, 1, 2, 3, 4)) !== "1,2,3,4") { throw new Exception("Test failed!"); }
}

test();
