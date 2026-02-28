<?php
function f($val, $text) {
    $indices = [];
    for ($index = 0; $index < strlen($text); $index++) {
        if ($text[$index] == $val) {
            $indices[] = $index;
        }
    }
    if (count($indices) == 0) {
        return -1;
    } else {
        return $indices[0];
    }
}
function candidate(...$args) {
    return f(...$args);
}

function test(): void {
    if (candidate("o", "fnmart") !== -1) { throw new Exception("Test failed!"); }
}

test();
