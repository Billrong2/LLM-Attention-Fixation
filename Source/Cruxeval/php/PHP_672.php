<?php
function f($text, $position, $value) {
    $length = strlen($text);
    $index = ($position % ($length + 2)) - 1;
    if ($index >= $length || $index < 0) {
        return $text;
    }
    $text_list = str_split($text);
    $text_list[$index] = $value;
    return implode('', $text_list);
}
function candidate(...$args) {
    return f(...$args);
}

function test(): void {
    if (candidate("1zd", 0, "m") !== "1zd") { throw new Exception("Test failed!"); }
}

test();
