<?php
function f($string) {
    $count = substr_count($string, ':');
    return substr_replace($string, '', strrpos($string, ':', $count - 1), 1);
}
function candidate(...$args) {
    return f(...$args);
}

function test(): void {
    if (candidate("1::1") !== "1:1") { throw new Exception("Test failed!"); }
}

test();
