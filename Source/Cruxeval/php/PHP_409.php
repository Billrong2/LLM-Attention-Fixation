<?php
function f($text, $char) {
    if ($text) {
        $text = ltrim($text, $char);
        $text = ltrim($text, $text[-1]);
        $text = substr($text, 0, -1) . strtoupper(substr($text, -1));
    }
    return $text;
}
function candidate(...$args) {
    return f(...$args);
}

function test(): void {
    if (candidate("querist", "u") !== "querisT") { throw new Exception("Test failed!"); }
}

test();
