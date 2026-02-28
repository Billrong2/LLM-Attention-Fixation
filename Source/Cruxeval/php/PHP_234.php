<?php
function f($text, $char) {
    $position = strlen($text);
    if (strpos($text, $char) !== false) {
        $position = strpos($text, $char);
        if ($position > 1) {
            $position = ($position + 1) % strlen($text);
        }
    }
    return $position;
}
function candidate(...$args) {
    return f(...$args);
}

function test(): void {
    if (candidate("wduhzxlfk", "w") !== 0) { throw new Exception("Test failed!"); }
}

test();
