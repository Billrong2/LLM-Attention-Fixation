<?php
function f($text) {
    $text = str_split($text);
    for ($i = count($text)-1; $i >= 0; $i--) {
        if (ctype_space($text[$i])) {
            $text[$i] = '&nbsp;';
        }
    }
    return implode('', $text);
}
function candidate(...$args) {
    return f(...$args);
}

function test(): void {
    if (candidate("   ") !== "&nbsp;&nbsp;&nbsp;") { throw new Exception("Test failed!"); }
}

test();
