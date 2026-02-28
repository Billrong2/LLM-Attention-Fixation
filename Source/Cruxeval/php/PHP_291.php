<?php
function f($dictionary, $arr) {
    $dictionary[$arr[0]] = [$arr[1]];
    if (count($dictionary[$arr[0]]) == $arr[1]) {
        $dictionary[$arr[0]] = $arr[0];
    }
    return $dictionary;
}
function candidate(...$args) {
    return f(...$args);
}

function test(): void {
    if (candidate(array(), array("a", 2)) !== array("a" => array(2))) { throw new Exception("Test failed!"); }
}

test();
