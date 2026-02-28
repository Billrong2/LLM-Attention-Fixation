<?php
function f($text, $char) {
    $length = strlen($text);
    $index = -1;
    for ($i = 0; $i < $length; $i++) {
        if ($text[$i] == $char) {
            $index = $i;
        }
    }
    if ($index == -1) {
        $index = intval($length / 2);
    }
    $new_text = str_split($text);
    unset($new_text[$index]);
    return implode('', $new_text);
}
function candidate(...$args) {
    return f(...$args);
}

function test(): void {
    if (candidate("o horseto", "r") !== "o hoseto") { throw new Exception("Test failed!"); }
}

test();
