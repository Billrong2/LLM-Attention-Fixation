<?php
function f($text, $insert) {
    $whitespaces = ['\t', '\r', '\v', ' ', '\f', '\n'];
    $clean = '';
    for ($i = 0; $i < strlen($text); $i++) {
        if (in_array($text[$i], $whitespaces)) {
            $clean .= $insert;
        } else {
            $clean .= $text[$i];
        }
    }
    return $clean;
}
function candidate(...$args) {
    return f(...$args);
}

function test(): void {
    if (candidate("pi wa", "chi") !== "pichiwa") { throw new Exception("Test failed!"); }
}

test();
