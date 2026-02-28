<?php
function f($L, $m, $start, $step) {
    array_splice($L, $start, 0, $m);
    for ($x = $start - 1; $x > 0; $x -= $step) {
        $start -= 1;
        $index = array_search($m, $L);
        $val = $L[$index-1];
        unset($L[$index-1]);
        array_splice($L, $start, 0, $val);
    }
    return $L;
}
function candidate(...$args) {
    return f(...$args);
}

function test(): void {
    if (candidate(array(1, 2, 7, 9), 3, 3, 2) !== array(1, 2, 7, 3, 9)) { throw new Exception("Test failed!"); }
}

test();
