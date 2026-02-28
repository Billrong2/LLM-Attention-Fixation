<?php
function f($digits) {
    $digits = array_reverse($digits);
    if (count($digits) < 2) {
        return $digits;
    }
    for ($i = 0; $i < count($digits); $i += 2) {
        $temp = $digits[$i];
        $digits[$i] = $digits[$i+1];
        $digits[$i+1] = $temp;
    }
    return $digits;
}
function candidate(...$args) {
    return f(...$args);
}

function test(): void {
    if (candidate(array(1, 2)) !== array(1, 2)) { throw new Exception("Test failed!"); }
}

test();
