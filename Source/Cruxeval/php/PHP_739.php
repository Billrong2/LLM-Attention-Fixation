<?php
function f($st, $pattern) {
    foreach ($pattern as $p) {
        if (!(str_starts_with($st, $p))) {
            return false;
        }
        $st = substr($st, strlen($p));
    }
    return true;
}
function candidate(...$args) {
    return f(...$args);
}

function test(): void {
    if (candidate("qwbnjrxs", array("jr", "b", "r", "qw")) !== false) { throw new Exception("Test failed!"); }
}

test();
