<?php
function f($k, $j) {
    $arr = [];
    for ($i = 0; $i < $k; $i++) {
        $arr[] = $j;
    }
    return $arr;
}
function candidate(...$args) {
    return f(...$args);
}

function test(): void {
    if (candidate(7, 5) !== array(5, 5, 5, 5, 5, 5, 5)) { throw new Exception("Test failed!"); }
}

test();
