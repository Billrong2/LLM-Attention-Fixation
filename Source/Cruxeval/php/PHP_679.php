<?php
function f($text) {
    if ($text === '') {
        return false;
    }
    $first_char = $text[0];
    if (is_numeric($text[0])) {
        return false;
    }
    for ($i = 0; $i < strlen($text); $i++) {
        $last_char = $text[$i];
        if ($last_char !== '_' && !ctype_alnum($last_char)) {
            return false;
        }
    }
    return true;
}
function candidate(...$args) {
    return f(...$args);
}

function test(): void {
    if (candidate("meet") !== true) { throw new Exception("Test failed!"); }
}

test();
