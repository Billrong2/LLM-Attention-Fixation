<?php
function f($text, $suffix) {
    if ($suffix && substr($text, -strlen($suffix)) === $suffix) {
        return substr($text, 0, -strlen($suffix));
    }
    return $text;
}
function candidate(...$args) {
    return f(...$args);
}

function test(): void {
    if (candidate("mathematics", "example") !== "mathematics") { throw new Exception("Test failed!"); }
}

test();
