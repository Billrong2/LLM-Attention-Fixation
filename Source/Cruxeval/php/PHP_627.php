<?php
function f($parts) {
    $result = array();
    foreach ($parts as $part) {
        $result[$part[0]] = $part[1];
    }
    return array_values($result);
}
function candidate(...$args) {
    return f(...$args);
}

function test(): void {
    if (candidate(array(array("u", 1), array("s", 7), array("u", -5))) !== array(-5, 7)) { throw new Exception("Test failed!"); }
}

test();
