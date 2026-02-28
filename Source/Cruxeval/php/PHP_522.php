<?php
function f($numbers) {
    $floats = array_map(function($n) {
        return $n % 1;
    }, $numbers);

    if (in_array(1, $floats)) {
        return $floats;
    } else {
        return [];
    }
}
function candidate(...$args) {
    return f(...$args);
}

function test(): void {
    if (candidate(array(100, 101, 102, 103, 104, 105, 106, 107, 108, 109, 110, 111, 112, 113, 114, 115, 116, 117, 118, 119)) !== array()) { throw new Exception("Test failed!"); }
}

test();
