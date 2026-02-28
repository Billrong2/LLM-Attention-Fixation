<?php
function f($array) {
    $result = array_reverse($array);
    $result = array_map(function($item) {
        return $item * 2;
    }, $result);
    return $result;
}
function candidate(...$args) {
    return f(...$args);
}

function test(): void {
    if (candidate(array(1, 2, 3, 4, 5)) !== array(10, 8, 6, 4, 2)) { throw new Exception("Test failed!"); }
}

test();
