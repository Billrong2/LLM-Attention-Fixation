<?php
function f($text, $char) {
    $index = strrpos($text, $char);
    $result = str_split($text);
    while ($index > 0) {
        $result[$index] = $result[$index-1];
        $result[$index-1] = $char;
        $index -= 2;
    }
    return implode('', $result);
}
function candidate(...$args) {
    return f(...$args);
}

function test(): void {
    if (candidate("qpfi jzm", "j") !== "jqjfj zm") { throw new Exception("Test failed!"); }
}

test();
