<?php
function f($text) {
    for ($i = 0; $i < strlen($text); $i++) {
        if ($text[$i] === strtoupper($text[$i]) && strtolower($text[$i - 1]) === $text[$i - 1]) {
            return true;
        }
    }
    return false;
}
function candidate(...$args) {
    return f(...$args);
}

function test(): void {
    if (candidate("jh54kkk6") !== true) { throw new Exception("Test failed!"); }
}

test();
