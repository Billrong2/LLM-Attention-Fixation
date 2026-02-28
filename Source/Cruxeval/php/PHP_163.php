<?php
function f($text, $space_symbol, $size) {
    $spaces = str_repeat($space_symbol, max(0, $size - strlen($text)));
    return $text . $spaces;
}
function candidate(...$args) {
    return f(...$args);
}

function test(): void {
    if (candidate("w", "))", 7) !== "w))))))))))))") { throw new Exception("Test failed!"); }
}

test();
