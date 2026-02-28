<?php
function f($text, $letter) {
    $letter = strtoupper($letter);
    $text = str_split($text);
    for ($i = 0; $i < count($text); $i++) {
        if ($text[$i] == $letter) {
            $text[$i] = strtoupper($text[$i]);
        }
    }
    return ucfirst(implode('', $text));
}
function candidate(...$args) {
    return f(...$args);
}

function test(): void {
    if (candidate("E wrestled evil until upperfeat", "e") !== "E wrestled evil until upperfeat") { throw new Exception("Test failed!"); }
}

test();
