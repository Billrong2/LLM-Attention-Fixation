<?php
function f($text) {
    $index = 1;
    while ($index < strlen($text)) {
        if ($text[$index] != $text[$index - 1]) {
            $index += 1;
        } else {
            $text1 = substr($text, 0, $index);
            $text2 = strtolower(substr($text, $index)) ^ strtoupper(substr($text, $index)) ^ substr($text, $index);
            return $text1 . $text2;
        }
    }
    return strtolower($text) ^ strtoupper($text) ^ $text;
}
function candidate(...$args) {
    return f(...$args);
}

function test(): void {
    if (candidate("USaR") !== "usAr") { throw new Exception("Test failed!"); }
}

test();
