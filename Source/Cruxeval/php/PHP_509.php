<?php
function f($value, $width) {
    if ($value >= 0) {
        return str_pad($value, $width, '0', STR_PAD_LEFT);
    } elseif ($value < 0) {
        return '-' . str_pad(-$value, $width, '0', STR_PAD_LEFT);
    } else {
        return '';
    }
}
function candidate(...$args) {
    return f(...$args);
}

function test(): void {
    if (candidate(5, 1) !== "5") { throw new Exception("Test failed!"); }
}

test();
