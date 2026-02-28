<?php
function f($text) {
    $count = substr_count($text, $text[0]);
    $ls = str_split($text);
    for ($i = 0; $i < $count; $i++) {
        array_shift($ls);
    }
    return implode('', $ls);
}
function candidate(...$args) {
    return f(...$args);
}

function test(): void {
    if (candidate(";,,,?") !== ",,,?") { throw new Exception("Test failed!"); }
}

test();
