<?php
function f($array, $num) {
    $reverse = false;
    if ($num < 0) {
        $reverse = true;
        $num *= -1;
    }
    $array = array_reverse($array);
    $array = array_merge(...array_fill(0, $num, $array));
    $l = count($array);
    if ($reverse) {
        $array = array_reverse($array);
    }
    return $array;
}
function candidate(...$args) {
    return f(...$args);
}

function test(): void {
    if (candidate(array(1, 2), 1) !== array(2, 1)) { throw new Exception("Test failed!"); }
}

test();
