<?php
function f($array) {
    while (in_array(-1, $array)) {
        array_splice($array, array_search(-1, $array), 1);
    }
    while (in_array(0, $array)) {
        array_pop($array);
    }
    while (in_array(1, $array)) {
        array_splice($array, array_search(1, $array), 1);
    }
    return $array;
}
function candidate(...$args) {
    return f(...$args);
}

function test(): void {
    if (candidate(array(0, 2)) !== array()) { throw new Exception("Test failed!"); }
}

test();
