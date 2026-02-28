<?php
function f($text, $num) {
    $req = $num - strlen($text);
    $text = str_pad($text, $num, '*');
    return substr($text, $req / 2, -($req / 2));
}
function candidate(...$args) {
    return f(...$args);
}

function test(): void {
    if (candidate("a", 19) !== "*") { throw new Exception("Test failed!"); }
}

test();
