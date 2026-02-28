<?php
function f($letters) {
    $count = 0;
    for ($i = 0; $i < strlen($letters); $i++) {
        if (is_numeric($letters[$i])) {
            $count++;
        }
    }
    return $count;
}
function candidate(...$args) {
    return f(...$args);
}

function test(): void {
    if (candidate("dp ef1 gh2") !== 2) { throw new Exception("Test failed!"); }
}

test();
