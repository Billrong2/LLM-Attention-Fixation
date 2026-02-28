<?php
function f($s) {
    while (count($s) > 1) {
        $s = array();
        $s[] = count($s);
    }
    return array_pop($s);
}
function candidate(...$args) {
    return f(...$args);
}

function test(): void {
    if (candidate(array(6, 1, 2, 3)) !== 0) { throw new Exception("Test failed!"); }
}

test();
