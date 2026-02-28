<?php
function f($text, $repl) {
    $trans = array_combine(str_split(strtolower($text)), str_split(strtolower($repl)));
    return strtr($text, $trans);
}
function candidate(...$args) {
    return f(...$args);
}

function test(): void {
    if (candidate("upper case", "lower case") !== "lwwer case") { throw new Exception("Test failed!"); }
}

test();
