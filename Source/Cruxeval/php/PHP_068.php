<?php
function f($text, $pref) {
    if (substr($text, 0, strlen($pref)) === $pref) {
        $n = strlen($pref);
        $text = implode('.', array_slice(explode('.', substr($text, $n)), 1)
            + array_slice(explode('.', substr($text, 0, $n)), 0, -1));
    }
    return $text;
}
function candidate(...$args) {
    return f(...$args);
}

function test(): void {
    if (candidate("omeunhwpvr.dq", "omeunh") !== "dq") { throw new Exception("Test failed!"); }
}

test();
