<?php
function f($text) {
    $t = $text;
    foreach(str_split($text) as $i) {
        $text = str_replace($i, '', $text);
    }
    return strlen($text) . $t;
}
function candidate(...$args) {
    return f(...$args);
}

function test(): void {
    if (candidate("ThisIsSoAtrocious") !== "0ThisIsSoAtrocious") { throw new Exception("Test failed!"); }
}

test();
