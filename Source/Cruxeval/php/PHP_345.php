<?php
function f($a, $b) {
    if ($a < $b) {
        return array($b, $a);
    }
    return array($a, $b);
}
function candidate(...$args) {
    return f(...$args);
}

function test(): void {
    if (candidate("ml", "mv") !== array("mv", "ml")) { throw new Exception("Test failed!"); }
}

test();
