<?php
function f($letters, $maxsplit) {
    $words = explode(' ', $letters);
    $selectedWords = array_slice($words, -$maxsplit);
    return implode('', $selectedWords);
}
function candidate(...$args) {
    return f(...$args);
}

function test(): void {
    if (candidate("elrts,SS ee", 6) !== "elrts,SSee") { throw new Exception("Test failed!"); }
}

test();
