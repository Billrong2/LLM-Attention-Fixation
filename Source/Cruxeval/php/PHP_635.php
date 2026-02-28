<?php
function f($text) {
    $valid_chars = ['-', '_', '+', '.', '/', ' '];
    $text = strtoupper($text);
    for ($i = 0; $i < strlen($text); $i++) {
        $char = $text[$i];
        if (!ctype_alnum($char) && !in_array($char, $valid_chars)) {
            return false;
        }
    }
    return true;
}
function candidate(...$args) {
    return f(...$args);
}

function test(): void {
    if (candidate("9.twCpTf.H7 HPeaQ^ C7I6U,C:YtW") !== false) { throw new Exception("Test failed!"); }
}

test();
