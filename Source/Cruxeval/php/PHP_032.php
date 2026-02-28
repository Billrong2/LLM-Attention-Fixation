<?php
function f($s, $sep) {
    $reverse = array_map(function($e) { return '*' . $e; }, explode($sep, $s));
    return implode(';', array_reverse($reverse));
}
function candidate(...$args) {
    return f(...$args);
}

function test(): void {
    if (candidate("volume", "l") !== "*ume;*vo") { throw new Exception("Test failed!"); }
}

test();
