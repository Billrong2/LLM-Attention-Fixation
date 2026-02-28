<?php
function f($text) {
    $a = explode(' ', trim($text));
    foreach ($a as $word) {
        if (!is_numeric($word)) {
            return '-';
        }
    }
    return implode(' ', $a);
}
function candidate(...$args) {
    return f(...$args);
}

function test(): void {
    if (candidate("d khqw whi fwi bbn 41") !== "-") { throw new Exception("Test failed!"); }
}

test();
