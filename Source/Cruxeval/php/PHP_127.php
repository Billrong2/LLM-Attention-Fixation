<?php
function f($text) {
    $s = explode("\n", $text);
    return count($s);
}
function candidate(...$args) {
    return f(...$args);
}

function test(): void {
    if (candidate("145\n\n12fjkjg") !== 3) { throw new Exception("Test failed!"); }
}

test();
