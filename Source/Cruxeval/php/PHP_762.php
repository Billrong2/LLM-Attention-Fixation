<?php
function f($text) {
    $text = strtolower($text);
    $capitalize = ucfirst($text);
    return substr($text, 0, 1) . substr($capitalize, 1);
}
function candidate(...$args) {
    return f(...$args);
}

function test(): void {
    if (candidate("this And cPanel") !== "this and cpanel") { throw new Exception("Test failed!"); }
}

test();
