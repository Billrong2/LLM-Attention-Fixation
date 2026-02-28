<?php
function f($s) {
    $d = explode('ar', $s);
    $lastElement = array_pop($d);
    $firstElement = implode('ar', $d);
    return $firstElement . " ar " . $lastElement;
}
function candidate(...$args) {
    return f(...$args);
}

function test(): void {
    if (candidate("xxxarmmarxx") !== "xxxarmm ar xx") { throw new Exception("Test failed!"); }
}

test();
