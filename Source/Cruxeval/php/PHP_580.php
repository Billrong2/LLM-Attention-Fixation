<?php
function f($text, $char) {
    $new_text = $text;
    $a = [];
    while (strpos($new_text, $char) !== false) {
        $a[] = strpos($new_text, $char);
        $new_text = substr_replace($new_text, "", strpos($new_text, $char), 1);
    }
    return $a;
}
function candidate(...$args) {
    return f(...$args);
}

function test(): void {
    if (candidate("rvr", "r") !== array(0, 1)) { throw new Exception("Test failed!"); }
}

test();
