<?php
function f($dic) {
    $d = array();
    foreach ($dic as $key => $value) {
        $d[$key] = array_shift($dic);
    }
    return $d;
}
function candidate(...$args) {
    return f(...$args);
}

function test(): void {
    if (candidate(array()) !== array()) { throw new Exception("Test failed!"); }
}

test();
