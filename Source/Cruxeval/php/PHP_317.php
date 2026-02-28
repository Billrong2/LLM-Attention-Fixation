<?php
function f($text, $a, $b) {
    $text = str_replace($a, $b, $text);
    return str_replace($b, $a, $text);
}
function candidate(...$args) {
    return f(...$args);
}

function test(): void {
    if (candidate(" vup a zwwo oihee amuwuuw! ", "a", "u") !== " vap a zwwo oihee amawaaw! ") { throw new Exception("Test failed!"); }
}

test();
