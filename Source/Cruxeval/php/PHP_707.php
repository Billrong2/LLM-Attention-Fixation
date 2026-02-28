<?php
function f($text, $position) {
    $length = strlen($text);
    $index = $position % ($length + 1);
    if ($position < 0 || $index < 0) {
        $index = -1;
    }
    $new_text = str_split($text);
    unset($new_text[$index]);
    return implode('', $new_text);
}
function candidate(...$args) {
    return f(...$args);
}

function test(): void {
    if (candidate("undbs l", 1) !== "udbs l") { throw new Exception("Test failed!"); }
}

test();
