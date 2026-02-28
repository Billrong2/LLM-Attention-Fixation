<?php
function f($array) {
    $return_arr = [];
    foreach ($array as $a) {
        $return_arr[] = $a;
    }
    return $return_arr;
}
function candidate(...$args) {
    return f(...$args);
}

function test(): void {
    if (candidate(array(array(1, 2, 3), array(), array(1, 2, 3))) !== array(array(1, 2, 3), array(), array(1, 2, 3))) { throw new Exception("Test failed!"); }
}

test();
