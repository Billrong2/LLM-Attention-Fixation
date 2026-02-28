<?php
function f($text, $value) {
    $left = strstr($text, $value, true);
    $right = substr(strstr($text, $value), strlen($value));
    return $right . $left;
}

function candidate(...$args) {
    return f(...$args);
}

function test(): void {
    if (candidate("difkj rinpx", "k") !== "j rinpxdif") { throw new Exception("Test failed!"); }
}

test();
