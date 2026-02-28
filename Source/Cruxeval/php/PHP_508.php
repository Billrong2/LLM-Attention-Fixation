<?php
function f($text, $sep, $maxsplit) {
    $splitted = explode($sep, $text, $maxsplit + 1);
    $length = count($splitted);
    $new_splitted = array_slice($splitted, 0, intval($length / 2));
    $new_splitted = array_reverse($new_splitted);
    $new_splitted = array_merge($new_splitted, array_slice($splitted, intval($length / 2)));
    return implode($sep, $new_splitted);
}
function candidate(...$args) {
    return f(...$args);
}

function test(): void {
    if (candidate("ertubwi", "p", 5) !== "ertubwi") { throw new Exception("Test failed!"); }
}

test();
