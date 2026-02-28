<?php
function f($s) {
    return strlen($s) == substr_count($s, '0') + substr_count($s, '1');
}
function candidate(...$args) {
    return f(...$args);
}

function test(): void {
    if (candidate("102") !== false) { throw new Exception("Test failed!"); }
}

test();
