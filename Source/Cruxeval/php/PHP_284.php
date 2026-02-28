<?php
function f($text, $prefix) {
    $idx = 0;
    for ($i = 0; $i < strlen($prefix); $i++) {
        if ($text[$idx] !== $prefix[$i]) {
            return null;
        }
        $idx++;
    }
    return substr($text, $idx);
}
function candidate(...$args) {
    return f(...$args);
}

function test(): void {
    if (candidate("bestest", "bestest") !== "") { throw new Exception("Test failed!"); }
}

test();
