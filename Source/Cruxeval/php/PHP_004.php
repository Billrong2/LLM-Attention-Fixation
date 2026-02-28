<?php
function f($array) {
    $s = ' ';
    $s .= implode('', $array);
    return $s;
}
function candidate(...$args) {
    return f(...$args);
}

function test(): void {
    if (candidate(array(" ", "  ", "    ", "   ")) !== "           ") { throw new Exception("Test failed!"); }
}

test();
