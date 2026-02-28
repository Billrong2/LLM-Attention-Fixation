<?php
function f($text, $symbols) {
    $count = 0;
    if ($symbols) {
        for ($i = 0; $i < strlen($symbols); $i++) {
            $count += 1;
        }
        $text = str_repeat($text, $count);
    }
    return substr(str_pad($text, strlen($text) + $count*2), 0, -2);
}
function candidate(...$args) {
    return f(...$args);
}

function test(): void {
    if (candidate("", "BC1ty") !== "        ") { throw new Exception("Test failed!"); }
}

test();
