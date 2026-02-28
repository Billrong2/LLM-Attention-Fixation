<?php
function f($text) {
    $count = strlen($text);
    for ($i = -$count+1; $i < 0; $i++) {
        $text = $text . $text[$i];
    }
    return $text;
}
function candidate(...$args) {
    return f(...$args);
}

function test(): void {
    if (candidate("wlace A") !== "wlace Alc l  ") { throw new Exception("Test failed!"); }
}

test();
