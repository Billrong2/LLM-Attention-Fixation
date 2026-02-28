<?php
function f($text) {
    global $g, $field;
    $field = str_replace(' ', '', $text);
    $g = str_replace('0', ' ', $text);
    $text = str_replace('1', 'i', $text);

    return $text;
}
function candidate(...$args) {
    return f(...$args);
}

function test(): void {
    if (candidate("00000000 00000000 01101100 01100101 01101110") !== "00000000 00000000 0ii0ii00 0ii00i0i 0ii0iii0") { throw new Exception("Test failed!"); }
}

test();
