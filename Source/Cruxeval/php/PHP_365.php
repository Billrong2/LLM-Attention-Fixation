<?php
function f($n, $s) {
    if (substr($s, 0, strlen($n)) === $n) {
        list($pre, $rest) = explode($n, $s, 2);
        return $pre . $n . substr($s, strlen($n));
    }
    return $s;
}
function candidate(...$args) {
    return f(...$args);
}

function test(): void {
    if (candidate("xqc", "mRcwVqXsRDRb") !== "mRcwVqXsRDRb") { throw new Exception("Test failed!"); }
}

test();
