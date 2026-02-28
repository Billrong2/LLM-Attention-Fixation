<?php
function f($nums) {
    $digits = [];
    foreach ($nums as $num) {
        if ((is_string($num) && is_numeric($num)) || is_int($num)) {
            $digits[] = $num;
        }
    }
    $digits = array_map('intval', $digits);
    return $digits;
}
function candidate(...$args) {
    return f(...$args);
}

function test(): void {
    if (candidate(array(0, 6, "1", "2", 0)) !== array(0, 6, 1, 2, 0)) { throw new Exception("Test failed!"); }
}

test();
