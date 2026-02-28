<?php
function f($text, $char) {
    if (substr($text, -strlen($char)) !== $char) {
        return f($char . $text, $char);
    }
    return $text;
}
function candidate(...$args) {
    return f(...$args);
}

function test(): void {
    if (candidate("staovk", "k") !== "staovk") { throw new Exception("Test failed!"); }
}

test();
