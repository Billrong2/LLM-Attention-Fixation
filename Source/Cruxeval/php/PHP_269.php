<?php
function f($array) {
    $zero_len = (count($array) - 1) % 3;
    for ($i = 0; $i < $zero_len; $i++) {
        $array[$i] = '0';
    }
    for ($i = $zero_len + 1; $i < count($array); $i += 3) {
        array_splice($array, $i - 1, 3, ['0', '0', '0']);
    }
    return $array;
}
function candidate(...$args) {
    return f(...$args);
}

function test(): void {
    if (candidate(array(9, 2)) !== array("0", 2)) { throw new Exception("Test failed!"); }
}

test();
