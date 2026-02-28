<?php
function f($dic) {
    foreach($dic as $key => $value) {
        $pairs[] = [$key, $value];
    }
    usort($pairs, function ($a, $b) {
        return strcmp($a[0], $b[0]);
    });
    return $pairs;
}
function candidate(...$args) {
    return f(...$args);
}

function test(): void {
    if (candidate(array("b" => 1, "a" => 2)) !== array(array("a", 2), array("b", 1))) { throw new Exception("Test failed!"); }
}

test();
