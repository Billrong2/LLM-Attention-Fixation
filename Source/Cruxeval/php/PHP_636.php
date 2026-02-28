<?php
function f($d) {
    $r = array();
    while (count($d) > 0) {
        $r = $r + $d;
        unset($d[max(array_keys($d))]);
    }
    return $r;
}
function candidate(...$args) {
    return f(...$args);
}

function test(): void {
    if (candidate(array(3 => "A3", 1 => "A1", 2 => "A2")) !== array(3 => "A3", 1 => "A1", 2 => "A2")) { throw new Exception("Test failed!"); }
}

test();
