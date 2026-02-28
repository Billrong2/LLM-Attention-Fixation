<?php
function f($array, $elem) {
    $result = $array;
    while (!empty($result)) {
        $key = key($result);
        $value = $result[$key];
        if ($elem == $key || $elem == $value) {
            $result = $array;
        }
        unset($result[$key]);
    }
    return $result;
}
function candidate(...$args) {
    return f(...$args);
}

function test(): void {
    if (candidate(array(), 1) !== array()) { throw new Exception("Test failed!"); }
}

test();
