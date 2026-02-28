<?php
function f($text, $suffix) {
    if ($suffix && strpos($text, $suffix[strlen($suffix) - 1]) !== false) {
        return f(rtrim($text, $suffix[strlen($suffix) - 1]), substr($suffix, 0, -1));
    } else {
        return $text;
    }
}
function candidate(...$args) {
    return f(...$args);
}

function test(): void {
    if (candidate("rpyttc", "cyt") !== "rpytt") { throw new Exception("Test failed!"); }
}

test();
