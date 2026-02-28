<?php
function f($array1, $array2) {
    $result = array_fill_keys($array1, null);
    foreach ($result as $key => $value) {
        $result[$key] = array_values(array_filter($array2, function($el) use ($key) { return $key * 2 > $el; }));
    }
    return $result;
}
function candidate(...$args) {
    return f(...$args);
}

function test(): void {
    if (candidate(array(0, 132), array(5, 991, 32, 997)) !== array(0 => array(), 132 => array(5, 32))) { throw new Exception("Test failed!"); }
}

test();
