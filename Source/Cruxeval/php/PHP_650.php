<?php
function f($string, $substring) {
    while (substr($string, 0, strlen($substring)) === $substring) {
        $string = substr($string, strlen($substring));
    }
    return $string;
}
function candidate(...$args) {
    return f(...$args);
}

function test(): void {
    if (candidate("", "A") !== "") { throw new Exception("Test failed!"); }
}

test();
