<?php
function f($text, $pref) {
    if (is_array($pref)) {
        return implode(', ', array_map(function($x) use ($text) {
            return strpos($text, $x) === 0;
        }, $pref));
    } else {
        return strpos($text, $pref) === 0;
    }
}
function candidate(...$args) {
    return f(...$args);
}

function test(): void {
    if (candidate("Hello World", "W") !== false) { throw new Exception("Test failed!"); }
}

test();
