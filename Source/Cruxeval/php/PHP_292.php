<?php
function f($text) {
    $new_text = str_split($text);
    foreach($new_text as $key => $value) {
        $new_text[$key] = is_numeric($value) ? $value : '*';
    }
    return implode('', $new_text);
}
function candidate(...$args) {
    return f(...$args);
}

function test(): void {
    if (candidate("5f83u23saa") !== "5*83*23***") { throw new Exception("Test failed!"); }
}

test();
