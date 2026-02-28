<?php
function f($text) {
    $new_text = $text;
    while (strlen($text) > 1 && $text[0] == $text[strlen($text) - 1]) {
        $new_text = $text = substr($text, 1, -1);
    }
    return $new_text;
}
function candidate(...$args) {
    return f(...$args);
}

function test(): void {
    if (candidate(")") !== ")") { throw new Exception("Test failed!"); }
}

test();
