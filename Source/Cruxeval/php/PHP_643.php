<?php
function f($text, $suffix) {
    if (substr($text, -strlen($suffix)) === $suffix) {
        $text = substr($text, 0, -1) . strtoupper(substr($text, -1));
    }
    return $text;
}
function candidate(...$args) {
    return f(...$args);
}

function test(): void {
    if (candidate("damdrodm", "m") !== "damdrodM") { throw new Exception("Test failed!"); }
}

test();
