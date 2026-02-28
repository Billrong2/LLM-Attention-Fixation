<?php
function f($s1, $s2) {
    $position = 1;
    $count = 0;
    while ($position > 0) {
        $position = strpos($s1, $s2, $position);
        $count += 1;
        if ($position !== false) {
            $position += 1;
        }
    }
    return $count;
}
function candidate(...$args) {
    return f(...$args);
}

function test(): void {
    if (candidate("xinyyexyxx", "xx") !== 2) { throw new Exception("Test failed!"); }
}

test();
