<?php
function f($needle, $haystack) {
    $count = 0;
    while (strpos($haystack, $needle) !== false) {
        $haystack = preg_replace('/' . preg_quote($needle, '/') . '/', '', $haystack, 1);
        $count++;
    }
    return $count;
}
function candidate(...$args) {
    return f(...$args);
}

function test(): void {
    if (candidate("a", "xxxaaxaaxx") !== 4) { throw new Exception("Test failed!"); }
}

test();
