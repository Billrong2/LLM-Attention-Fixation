<?php
function f($s, $n) {
    if (strlen($s) < $n) {
        return $s;
    } else {
        return substr($s, $n);
    }
}
function candidate(...$args) {
    return f(...$args);
}

function test(): void {
    if (candidate("try.", 5) !== "try.") { throw new Exception("Test failed!"); }
}

test();
