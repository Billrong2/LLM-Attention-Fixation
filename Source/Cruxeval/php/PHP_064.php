<?php
function f($text, $size) {
    $counter = strlen($text);
    for ($i = 0; $i < $size-intval($size%2); $i++) {
        $text = ' ' . $text . ' ';
        $counter += 2;
        if ($counter >= $size) {
            return $text;
        }
    }
}
function candidate(...$args) {
    return f(...$args);
}

function test(): void {
    if (candidate("7", 10) !== "     7     ") { throw new Exception("Test failed!"); }
}

test();
