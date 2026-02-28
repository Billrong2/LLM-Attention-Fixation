<?php
function f($s, $char) {
    $base = str_repeat($char, substr_count($s, $char) + 1);
    return rtrim($s, $base);
}
function candidate(...$args) {
    return f(...$args);
}

function test(): void {
    if (candidate("mnmnj krupa...##!@#!@#$$@##", "@") !== "mnmnj krupa...##!@#!@#$$@##") { throw new Exception("Test failed!"); }
}

test();
