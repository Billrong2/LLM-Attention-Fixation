<?php
function f($string, $prefix) {
    if (substr($string, 0, strlen($prefix)) === $prefix) {
        return substr($string, strlen($prefix));
    }
    return $string;
}
function candidate(...$args) {
    return f(...$args);
}

function test(): void {
    if (candidate("Vipra", "via") !== "Vipra") { throw new Exception("Test failed!"); }
}

test();
