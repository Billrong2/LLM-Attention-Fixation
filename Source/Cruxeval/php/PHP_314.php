<?php
function f($text) {
    if (strpos($text, ',') !== false) {
        list($before, $after) = explode(',', $text, 2);
        return $after . ' ' . $before;
    }
    return ', ' . substr($text, strrpos($text, ' ') + 1) . ' 0';
}
function candidate(...$args) {
    return f(...$args);
}

function test(): void {
    if (candidate("244, 105, -90") !== " 105, -90 244") { throw new Exception("Test failed!"); }
}

test();
