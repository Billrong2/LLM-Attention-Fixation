<?php
function f($text, $suffix) {
    $text .= $suffix;
    while (substr($text, -strlen($suffix)) === $suffix) {
        $text = substr($text, 0, -1);
    }
    return $text;
}
function candidate(...$args) {
    return f(...$args);
}

function test(): void {
    if (candidate("faqo osax f", "f") !== "faqo osax ") { throw new Exception("Test failed!"); }
}

test();
