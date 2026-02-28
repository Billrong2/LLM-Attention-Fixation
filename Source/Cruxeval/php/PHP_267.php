<?php
function f($text, $space) {
    if ($space < 0) {
        return $text;
    }
    return str_pad($text, strlen($text) / 2 + $space, " ", STR_PAD_RIGHT);
}
function candidate(...$args) {
    return f(...$args);
}

function test(): void {
    if (candidate("sowpf", -7) !== "sowpf") { throw new Exception("Test failed!"); }
}

test();
