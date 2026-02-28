<?php
function f($text) {
    $ls = str_split($text);
    $ls[0] = strtoupper($ls[0]);
    $ls[count($ls) - 1] = strtoupper($ls[count($ls) - 1]);
    $new_text = implode('', $ls);
    return ctype_upper($new_text[0]) && ctype_lower(substr($new_text, 1));
}
function candidate(...$args) {
    return f(...$args);
}

function test(): void {
    if (candidate("Josh") !== false) { throw new Exception("Test failed!"); }
}

test();
