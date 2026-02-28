<?php
function f($filename) {
    $suffix = explode('.', $filename)[count(explode('.', $filename)) - 1];
    $f2 = $filename . strrev($suffix);
    return substr($f2, -strlen($suffix)) === $suffix;
}
function candidate(...$args) {
    return f(...$args);
}

function test(): void {
    if (candidate("docs.doc") !== false) { throw new Exception("Test failed!"); }
}

test();
