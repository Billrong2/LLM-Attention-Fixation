<?php
function f($text) {
    foreach (str_split($text) as $space) {
        if ($space == ' ') {
            $text = ltrim($text);
        } else {
            $text = str_replace('cd', $space, $text);
        }
    }
    return $text;
}
function candidate(...$args) {
    return f(...$args);
}

function test(): void {
    if (candidate("lorem ipsum") !== "lorem ipsum") { throw new Exception("Test failed!"); }
}

test();
