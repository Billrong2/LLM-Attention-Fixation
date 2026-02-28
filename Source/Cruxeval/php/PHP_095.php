<?php
function f($zoo) {
    $result = array();
    foreach ($zoo as $k => $v) {
        $result[$v] = $k;
    }
    return $result;
}
function candidate(...$args) {
    return f(...$args);
}

function test(): void {
    if (candidate(array("AAA" => "fr")) !== array("fr" => "AAA")) { throw new Exception("Test failed!"); }
}

test();
