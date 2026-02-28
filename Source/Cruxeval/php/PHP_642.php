<?php
function f($text) {
    $i = 0;
    while ($i < strlen($text) && ctype_space($text[$i])) {
        $i++;
    }
    if ($i == strlen($text)) {
        return 'space';
    }
    return 'no';
}
function candidate(...$args) {
    return f(...$args);
}

function test(): void {
    if (candidate("     ") !== "space") { throw new Exception("Test failed!"); }
}

test();
