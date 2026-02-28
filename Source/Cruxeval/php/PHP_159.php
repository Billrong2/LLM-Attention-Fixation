<?php
function f($st) {
    $swapped = '';
    $length = strlen($st);
    for ($i = $length - 1; $i >= 0; $i--) {
        $swapped .= strtoupper($st[$i]) === $st[$i] ? strtolower($st[$i]) : strtoupper($st[$i]);
    }
    return $swapped;
}
function candidate(...$args) {
    return f(...$args);
}

function test(): void {
    if (candidate("RTiGM") !== "mgItr") { throw new Exception("Test failed!"); }
}

test();
