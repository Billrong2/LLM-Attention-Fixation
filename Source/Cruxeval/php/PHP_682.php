<?php
function f($text, $length, $index) {
    $ls = explode(' ', $text);
    $ls = array_slice($ls, -$index);
    $result = array();
    foreach ($ls as $l) {
        $result[] = substr($l, 0, $length);
    }
    return implode('_', $result);
}
function candidate(...$args) {
    return f(...$args);
}

function test(): void {
    if (candidate("hypernimovichyp", 2, 2) !== "hy") { throw new Exception("Test failed!"); }
}

test();
