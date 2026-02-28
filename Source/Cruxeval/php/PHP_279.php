<?php
function f($text) {
    $ans = '';
    while ($text != '') {
        list($x, $sep, $text) = explode('(', $text, 2);
        $ans = $x . str_replace('(', '|', $sep) . $ans;
        $ans = $ans . $text[0] . $ans;
        $text = substr($text, 1);
    }
    return $ans;
}
function candidate(...$args) {
    return f(...$args);
}

function test(): void {
    if (candidate("") !== "") { throw new Exception("Test failed!"); }
}

test();
