<?php
function f($array) {
    $d = array();
    foreach ($array as list($key, $value)) {
        $d[$key] = $value;
        if ($value < 0 || $value > 9) {
            return null;
        }
    }
    return $d;
}
function candidate(...$args) {
    return f(...$args);
}

function test(): void {
    if (candidate(array(array(8, 5), array(8, 2), array(5, 3))) !== array(8 => 2, 5 => 3)) { throw new Exception("Test failed!"); }
}

test();
