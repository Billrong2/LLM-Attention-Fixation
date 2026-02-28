<?php
function f($text, $characters) {
    for ($i = 0; $i < strlen($characters); $i++) {
        $text = rtrim($text, $characters[$i]);
    }
    return $text;
}
function candidate(...$args) {
    return f(...$args);
}

function test(): void {
    if (candidate("r;r;r;r;r;r;r;r;r", "x.r") !== "r;r;r;r;r;r;r;r;") { throw new Exception("Test failed!"); }
}

test();
