<?php
function f($number) {
    $transl = ['A' => 1, 'B' => 2, 'C' => 3, 'D' => 4, 'E' => 5];
    $result = [];
    foreach ($transl as $key => $value) {
        if ($value % $number == 0) {
            $result[] = $key;
        }
    }
    return $result;
}
function candidate(...$args) {
    return f(...$args);
}

function test(): void {
    if (candidate(2) !== array("B", "D")) { throw new Exception("Test failed!"); }
}

test();
