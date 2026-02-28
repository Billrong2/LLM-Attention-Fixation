<?php
function f($numbers, $num, $val) {
    while (count($numbers) < $num) {
        array_splice($numbers, intval(count($numbers) / 2), 0, $val);
    }
    for ($i = 0; $i < intval(count($numbers) / ($num - 1)) - 4; $i++) {
        array_splice($numbers, intval(count($numbers) / 2), 0, $val);
    }
    return implode(' ', $numbers);
}
function candidate(...$args) {
    return f(...$args);
}

function test(): void {
    if (candidate(array(), 0, 1) !== "") { throw new Exception("Test failed!"); }
}

test();
