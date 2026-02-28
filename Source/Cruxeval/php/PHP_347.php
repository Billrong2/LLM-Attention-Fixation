<?php
function f($text) {
    $ls = str_split($text);
    $length = count($ls);
    for ($i = 0; $i < $length; $i++) {
        array_splice($ls, $i, 0, $ls[$i]);
    }
    return str_pad(implode('', $ls), $length * 2, ' ', STR_PAD_RIGHT);
}
function candidate(...$args) {
    return f(...$args);
}

function test(): void {
    if (candidate("hzcw") !== "hhhhhzcw") { throw new Exception("Test failed!"); }
}

test();
