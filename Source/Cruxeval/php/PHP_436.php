<?php
function f($s, $characters) {
    $result = [];
    foreach ($characters as $index) {
        $result[] = substr($s, $index, 1);
    }
    return $result;
}
function candidate(...$args) {
    return f(...$args);
}

function test(): void {
    if (candidate("s7 6s 1ss", array(1, 3, 6, 1, 2)) !== array("7", "6", "1", "7", " ")) { throw new Exception("Test failed!"); }
}

test();
