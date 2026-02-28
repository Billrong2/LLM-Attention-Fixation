<?php
function f($array, $value) {
    $reversedArray = array_reverse($array);
    array_pop($reversedArray);
    $odd = [];
    while (!empty($reversedArray)) {
        $tmp = [];
        $tmp[array_pop($reversedArray)] = $value;
        $odd[] = $tmp;
    }
    $result = [];
    while (!empty($odd)) {
        $result = array_merge($result, array_pop($odd));
    }
    return $result;
}
function candidate(...$args) {
    return f(...$args);
}

function test(): void {
    if (candidate(array("23"), 123) !== array()) { throw new Exception("Test failed!"); }
}

test();
