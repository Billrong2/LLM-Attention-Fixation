<?php
function f($text) {
    $result = '';
    $i = strlen($text) - 1;
    while ($i >= 0) {
        $c = $text[$i];
        if (ctype_alpha($c)) {
            $result .= $c;
        }
        $i--;
    }
    return $result;
}
function candidate(...$args) {
    return f(...$args);
}

function test(): void {
    if (candidate("102x0zoq") !== "qozx") { throw new Exception("Test failed!"); }
}

test();
