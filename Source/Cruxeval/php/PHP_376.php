<?php
function f($text) {
    for ($i = 0; $i < strlen($text); $i++) {
        if (substr($text, 0, $i) === "two") {
            return substr($text, $i);
        }
    }
    return 'no';
}
function candidate(...$args) {
    return f(...$args);
}

function test(): void {
    if (candidate("2two programmers") !== "no") { throw new Exception("Test failed!"); }
}

test();
