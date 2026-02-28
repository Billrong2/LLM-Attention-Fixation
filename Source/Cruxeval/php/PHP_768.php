<?php
function f($s, $o) {
    if (strpos($s, $o) === 0) {
        return $s;
    }
    return $o . f($s, substr($o, -2, strlen($o)-2));
}
function candidate(...$args) {
    return f(...$args);
}

function test(): void {
    if (candidate("abba", "bab") !== "bababba") { throw new Exception("Test failed!"); }
}

test();
