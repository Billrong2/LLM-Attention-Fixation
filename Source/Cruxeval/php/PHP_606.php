<?php
function f($value) {
    $ls = str_split($value);
    $ls[] = 'NHIB';
    return implode('', $ls);
}
function candidate(...$args) {
    return f(...$args);
}

function test(): void {
    if (candidate("ruam") !== "ruamNHIB") { throw new Exception("Test failed!"); }
}

test();
