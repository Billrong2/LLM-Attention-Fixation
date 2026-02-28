<?php
function f($text) {
    for ($i = strlen($text) - 1; $i > 0; $i--) {
        if (!ctype_upper($text[$i])) {
            return substr($text, 0, $i);
        }
    }
    return '';
}
function candidate(...$args) {
    return f(...$args);
}

function test(): void {
    if (candidate("SzHjifnzog") !== "SzHjifnzo") { throw new Exception("Test failed!"); }
}

test();
