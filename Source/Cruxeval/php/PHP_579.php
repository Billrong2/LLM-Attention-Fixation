<?php
function f($text) {
    if(ucwords($text) === $text) {
        if(strlen($text) > 1 && strtolower($text) !== $text) {
            return strtolower($text[0]) . substr($text, 1);
        }
    } elseif(ctype_alpha($text)) {
        return ucfirst($text);
    }
    return $text;
}
function candidate(...$args) {
    return f(...$args);
}

function test(): void {
    if (candidate("") !== "") { throw new Exception("Test failed!"); }
}

test();
