<?php
function f($array) {
    $a = [];
    $array = array_reverse($array);
    foreach ($array as $value) {
        if ($value != 0) {
            array_push($a, $value);
        }
    }
    $a = array_reverse($a);
    return $a;
}
function candidate(...$args) {
    return f(...$args);
}

function test(): void {
    if (candidate(array()) !== array()) { throw new Exception("Test failed!"); }
}

test();
