<?php
function f($text, $character) {
    $subject = substr($text, strrpos($text, $character));
    return str_repeat($subject, substr_count($text, $character));
}
function candidate(...$args) {
    return f(...$args);
}

function test(): void {
    if (candidate("h ,lpvvkohh,u", "i") !== "") { throw new Exception("Test failed!"); }
}

test();
