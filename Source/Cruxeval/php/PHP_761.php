<?php
function f($array) {
    $output = $array;
    for ($i = 0; $i < count($output); $i += 2) {
        $output[$i] = $output[count($output) - 1 - ($i / 2)];
    }
    $output = array_reverse($output);
    return $output;
}
function candidate(...$args) {
    return f(...$args);
}

function test(): void {
    if (candidate(array()) !== array()) { throw new Exception("Test failed!"); }
}

test();
