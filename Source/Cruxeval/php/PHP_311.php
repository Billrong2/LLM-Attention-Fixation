<?php
function f($text) {
    $text = str_replace(['#', '$'], ['1', '5'], $text);
    return is_numeric($text) ? 'yes' : 'no';
}
function candidate(...$args) {
    return f(...$args);
}

function test(): void {
    if (candidate("A") !== "no") { throw new Exception("Test failed!"); }
}

test();
