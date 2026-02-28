<?php
function f($text, $value) {
    $new_text = str_split($text);
    try {
        $new_text[] = $value;
        $length = count($new_text);
    } catch (Exception $e) {
        $length = 0;
    }
    return '[' . strval($length) . ']';
}
function candidate(...$args) {
    return f(...$args);
}

function test(): void {
    if (candidate("abv", "a") !== "[4]") { throw new Exception("Test failed!"); }
}

test();
