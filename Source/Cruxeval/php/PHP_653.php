<?php
function f($text, $letter) {
    $t = $text;
    foreach(str_split($text) as $alph) {
        $t = str_replace($alph, "", $t);
    }
    return count(explode($letter, $t));
}
function candidate(...$args) {
    return f(...$args);
}

function test(): void {
    if (candidate("c, c, c ,c, c", "c") !== 1) { throw new Exception("Test failed!"); }
}

test();
