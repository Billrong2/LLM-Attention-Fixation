<?php
function f($text) {
    $a = [];
    for ($i = 0; $i < strlen($text); $i++) {
        if (!is_numeric($text[$i])) {
            $a[] = $text[$i];
        }
    }
    return implode('', $a);
}
function candidate(...$args) {
    return f(...$args);
}

function test(): void {
    if (candidate("seiq7229 d27") !== "seiq d") { throw new Exception("Test failed!"); }
}

test();
