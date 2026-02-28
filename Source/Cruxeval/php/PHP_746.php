<?php
function f($dct) {
    $values = array_values($dct);
    $result = array();
    foreach ($values as $value) {
        $item = explode('.', $value)[0] . '@pinc.uk';
        $result[$value] = $item;
    }
    return $result;
}
function candidate(...$args) {
    return f(...$args);
}

function test(): void {
    if (candidate(array()) !== array()) { throw new Exception("Test failed!"); }
}

test();
