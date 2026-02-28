<?php
function f($text, $pref) {
    $length = strlen($pref);
    if ($pref === substr($text, 0, $length)) {
        return substr($text, $length);
    }
    return $text;
}
function candidate(...$args) {
    return f(...$args);
}

function test(): void {
    if (candidate("kumwwfv", "k") !== "umwwfv") { throw new Exception("Test failed!"); }
}

test();
