<?php
function f($array, $elem) {
    $reversedArray = array_reverse($array);
    try {
        $found = array_search($elem, $reversedArray);
    } finally {
        array_reverse($array);
    }
    return $found;
}
function candidate(...$args) {
    return f(...$args);
}

function test(): void {
    if (candidate(array(5, -3, 3, 2), 2) !== 0) { throw new Exception("Test failed!"); }
}

test();
