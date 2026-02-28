<?php
function f($text) {
    if ($text === '42.42') {
        return true;
    }

    for ($i = 3; $i < strlen($text) - 3; $i++) {
        if ($text[$i] === '.' && is_numeric(substr($text, $i - 3)) && is_numeric(substr($text, 0, $i))) {
            return true;
        }
    }

    return false;
}
function candidate(...$args) {
    return f(...$args);
}

function test(): void {
    if (candidate("123E-10") !== false) { throw new Exception("Test failed!"); }
}

test();
