<?php
function f($d) {
    $dCopy = $d;
    foreach ($dCopy as $key => $value) {
        foreach ($value as $index => $item) {
            $value[$index] = strtoupper($item);
        }
        $dCopy[$key] = $value;
    }
    return $dCopy;
}
function candidate(...$args) {
    return f(...$args);
}

function test(): void {
    if (candidate(array("X" => array("x", "y"))) !== array("X" => array("X", "Y"))) { throw new Exception("Test failed!"); }
}

test();
