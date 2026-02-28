<?php
function f($array) {
    $new_array = array_reverse($array);
    return array_map(function($x) {
        return $x * $x;
    }, $new_array);
}
function candidate(...$args) {
    return f(...$args);
}

function test(): void {
    if (candidate(array(1, 2, 1)) !== array(1, 4, 1)) { throw new Exception("Test failed!"); }
}

test();
