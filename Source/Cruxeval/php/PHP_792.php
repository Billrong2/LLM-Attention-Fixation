<?php
function f($l1, $l2) {
    if (count($l1) != count($l2)) {
        return [];
    }
    $result = [];
    foreach ($l1 as $key) {
        $result[$key] = $l2;
    }
    return $result;
}
function candidate(...$args) {
    return f(...$args);
}

function test(): void {
    if (candidate(array("a", "b"), array("car", "dog")) !== array("a" => array("car", "dog"), "b" => array("car", "dog"))) { throw new Exception("Test failed!"); }
}

test();
