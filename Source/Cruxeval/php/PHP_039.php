<?php
function f($array, $elem) {
    if (in_array($elem, $array)) {
        return array_search($elem, $array);
    }
    return -1;
}
function candidate(...$args) {
    return f(...$args);
}

function test(): void {
    if (candidate(array(6, 2, 7, 1), 6) !== 0) { throw new Exception("Test failed!"); }
}

test();
