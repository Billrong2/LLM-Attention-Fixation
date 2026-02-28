<?php
function f($text) {
    $ls = str_split($text);
    for ($i = 0; $i < count($ls); $i++) {
        if ($ls[$i] != '+') {
            array_splice($ls, $i, 0, ['*', '+']);
            break;
        }
    }
    return implode('+', $ls);
}
function candidate(...$args) {
    return f(...$args);
}

function test(): void {
    if (candidate("nzoh") !== "*+++n+z+o+h") { throw new Exception("Test failed!"); }
}

test();
