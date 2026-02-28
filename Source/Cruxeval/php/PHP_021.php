<?php
function f($array) {
    $n = array_pop($array);
    array_push($array, $n, $n);
    return $array;
}
function candidate(...$args) {
    return f(...$args);
}

function test(): void {
    if (candidate(array(1, 1, 2, 2)) !== array(1, 1, 2, 2, 2)) { throw new Exception("Test failed!"); }
}

test();
