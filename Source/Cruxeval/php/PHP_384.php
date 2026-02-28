<?php
function f($text, $chars) {
    $chars = str_split($chars);
    $text = str_split($text);
    $new_text = $text;
    while (count($new_text) > 0 && count($text) > 0) {
        if (in_array($new_text[0], $chars)) {
            array_shift($new_text);
        } else {
            break;
        }
    }
    return implode('', $new_text);
}
function candidate(...$args) {
    return f(...$args);
}

function test(): void {
    if (candidate("asfdellos", "Ta") !== "sfdellos") { throw new Exception("Test failed!"); }
}

test();
