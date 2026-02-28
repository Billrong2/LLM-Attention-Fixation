<?php
function f($sentences) {
    $sentences_arr = explode('.', $sentences);
    if (array_reduce($sentences_arr, function($carry, $sentence) {
        return $carry && is_numeric($sentence);
    }, true)) {
        return 'oscillating';
    } else {
        return 'not oscillating';
    }
}
function candidate(...$args) {
    return f(...$args);
}

function test(): void {
    if (candidate("not numbers") !== "not oscillating") { throw new Exception("Test failed!"); }
}

test();
