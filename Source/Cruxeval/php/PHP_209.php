<?php
function f($prefix, $s) {
    if (substr($prefix, 0, strlen($s)) == $s) {
        return substr($prefix, strlen($s));
    }
    return $prefix;
}
function candidate(...$args) {
    return f(...$args);
}

function test(): void {
    if (candidate("hymi", "hymifulhxhzpnyihyf") !== "hymi") { throw new Exception("Test failed!"); }
}

test();
