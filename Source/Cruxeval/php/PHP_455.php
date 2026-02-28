<?php
function f($text) {
    $uppers = 0;
    for ($i = 0; $i < strlen($text); $i++) {
        if (ctype_upper($text[$i])) {
            $uppers++;
        }
    }
    return $uppers >= 10 ? strtoupper($text) : $text;
}
function candidate(...$args) {
    return f(...$args);
}

function test(): void {
    if (candidate("?XyZ") !== "?XyZ") { throw new Exception("Test failed!"); }
}

test();
