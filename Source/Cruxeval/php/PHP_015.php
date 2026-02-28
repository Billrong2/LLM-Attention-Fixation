<?php
function f($text, $wrong, $right) {
    $new_text = str_replace($wrong, $right, $text);
    return strtoupper($new_text);
}
function candidate(...$args) {
    return f(...$args);
}

function test(): void {
    if (candidate("zn kgd jw lnt", "h", "u") !== "ZN KGD JW LNT") { throw new Exception("Test failed!"); }
}

test();
