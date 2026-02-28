<?php
function f($text) {
    $text = str_replace('-', '', strtolower($text));
    $d = [];
    for ($i = 0; $i < strlen($text); $i++) {
        $char = $text[$i];
        if (array_key_exists($char, $d)) {
            $d[$char]++;
        } else {
            $d[$char] = 1;
        }
    }
    asort($d);
    return array_values($d);
}
function candidate(...$args) {
    return f(...$args);
}

function test(): void {
    if (candidate("x--y-z-5-C") !== array(1, 1, 1, 1, 1)) { throw new Exception("Test failed!"); }
}

test();
