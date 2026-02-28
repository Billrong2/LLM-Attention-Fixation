<?php
function f($s) {
    $arr = str_split(trim($s));
    $arr = array_reverse($arr);
    return implode('', $arr);
}
function candidate(...$args) {
    return f(...$args);
}

function test(): void {
    if (candidate("   OOP   ") !== "POO") { throw new Exception("Test failed!"); }
}

test();
