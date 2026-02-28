<?php
function f($array, $arr) {
    $result = [];
    foreach ($arr as $s) {
        $result = array_merge($result, array_filter(explode($arr[array_search($s, $array)], $s), function($l){ return $l !== ''; }));
    }
    return $result;
}
function candidate(...$args) {
    return f(...$args);
}

function test(): void {
    if (candidate(array(), array()) !== array()) { throw new Exception("Test failed!"); }
}

test();
