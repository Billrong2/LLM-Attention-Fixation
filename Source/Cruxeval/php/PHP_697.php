<?php
function f($s, $sep) {
    $sep_index = strpos($s, $sep);
    $prefix = substr($s, 0, $sep_index);
    $middle = substr($s, $sep_index, strlen($sep));
    $right_str = substr($s, $sep_index + strlen($sep));
    return array($prefix, $middle, $right_str);
}
function candidate(...$args) {
    return f(...$args);
}

function test(): void {
    if (candidate("not it", "") !== array("", "", "not it")) { throw new Exception("Test failed!"); }
}

test();
