<?php
function f($text) {
    $ls = strrev($text);
    $text2 = '';
    for ($i = strlen($ls) - 3; $i > 0; $i -= 3) {
        $text2 .= implode('---', str_split(substr($ls, $i, 3))) . '---';
    }
    return substr($text2, 0, -3);
}
function candidate(...$args) {
    return f(...$args);
}

function test(): void {
    if (candidate("scala") !== "a---c---s") { throw new Exception("Test failed!"); }
}

test();
